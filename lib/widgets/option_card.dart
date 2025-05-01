import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (isAnswered) {
        if (isSelected) {
          return isCorrect ? Colors.green : Colors.red;
        } else if (isCorrect) {
          return Colors.green;
        }
      }
      return Colors.white;
    }

    return Card(
      color: getColor(),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            optionText,
            style: TextStyle(
              fontSize: 16,
              color: isAnswered && (isSelected || isCorrect)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}