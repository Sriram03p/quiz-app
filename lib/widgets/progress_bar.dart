import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentIndex;
  final int total;

  const ProgressBar({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (currentIndex + 1) / total,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(
          'Question ${currentIndex + 1} of $total',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}