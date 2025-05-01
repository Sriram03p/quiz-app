import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_ap/providers/quiz_provider.dart';
import 'package:quiz_ap/screens/leaderboard_screen.dart';
import 'package:quiz_ap/screens/quiz_screen.dart';
import 'package:quiz_ap/screens/question_list_screen.dart'; // Make sure this import exists

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  const PopupMenuItem(
                    value: 'manage',
                    child: Text('Manage Questions'),
                  ),
                  PopupMenuItem(
                    value: 'source',
                    child: Row(
                      children: [
                        const Text('Use Local Questions'),
                        const Spacer(),
                        Switch(
                          value: quizProvider.useLocalQuestions,
                          onChanged: (value) {
                            Navigator.pop(context);
                            quizProvider.toggleQuestionSource(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ).then((value) {
                if (value == 'manage') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuestionListScreen(),
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/quiz_icon.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome to Quiz App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Test your knowledge with our quiz!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Use Local Questions'),
              value: quizProvider.useLocalQuestions,
              onChanged: (value) {
                quizProvider.toggleQuestionSource(value);
              },
            ),
            const SizedBox(height: 20),
            if (quizProvider.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  if (quizProvider.questions.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No questions available'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                );
              },
              child: const Text(
                'View Leaderboard',
                style: TextStyle(fontSize: 16),
              ),
            ),
            if (quizProvider.error != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${quizProvider.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
