import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_ap/providers/quiz_provider.dart';
import 'package:quiz_ap/screens/result_screen.dart';
import 'package:quiz_ap/widgets/option_card.dart';
import 'package:quiz_ap/widgets/progress_bar.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    if (quizProvider.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text('No questions available'),
        ),
      );
    }

    final question = quizProvider.questions[quizProvider.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'Score: ${quizProvider.score}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProgressBar(
              currentIndex: quizProvider.currentQuestionIndex,
              total: quizProvider.questions.length,
            ),
            const SizedBox(height: 30),
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  return OptionCard(
                    optionText: question.options[index],
                    isSelected: quizProvider.selectedOptionIndex == index,
                    isCorrect: index == question.correctAnswerIndex,
                    isAnswered: quizProvider.isAnswered,
                    onTap: () {
                      if (!quizProvider.isAnswered) {
                        quizProvider.checkAnswer(index);
                      }
                    },
                  );
                },
              ),
            ),
            if (quizProvider.isAnswered)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (quizProvider.currentQuestionIndex <
                        quizProvider.questions.length - 1) {
                      quizProvider.nextQuestion();
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResultScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    quizProvider.currentQuestionIndex <
                        quizProvider.questions.length - 1
                        ? 'Next Question'
                        : 'See Results',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}