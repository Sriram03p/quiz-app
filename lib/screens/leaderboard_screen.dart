import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_ap/providers/leaderboard_provider.dart';
import 'package:quiz_ap/screens/home_screen.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderboardProvider = Provider.of<LeaderboardProvider>(context);
    final scores = leaderboardProvider.scores;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Leaderboard'),
                  content: const Text(
                      'Are you sure you want to clear all scores?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await leaderboardProvider.clearScores();
                        Navigator.pop(context);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: scores.isEmpty
          ? const Center(
        child: Text(
          'No scores yet!',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: scores.length,
        itemBuilder: (context, index) {
          final score = scores[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(score.userName),
            subtitle: Text(
                '${score.dateTime.day}/${score.dateTime.month}/${score.dateTime.year}'),
            trailing: Text(
              '${score.score}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}