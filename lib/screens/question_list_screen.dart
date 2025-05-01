import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_ap/models/question.dart';
import 'package:quiz_ap/providers/quiz_provider.dart';
import 'package:quiz_ap/screens/edit_question_screen.dart';
import 'package:quiz_ap/widgets/fade_animation.dart';

class QuestionListScreen extends StatelessWidget {
  const QuestionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Questions'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quizProvider.localQuestions.length,
        itemBuilder: (context, index) {
          final question = quizProvider.localQuestions[index];
          return FadeAnimation(
            delay: index * 0.1,
            child: Card(
              child: ListTile(
                title: Text(question.questionText),
                subtitle: Text(
                  'Correct: ${question.options[question.correctAnswerIndex]}',
                  style: const TextStyle(color: Colors.green),
                ),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditQuestionScreen(
                        question: question,
                        questionIndex: index,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditQuestionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}