import 'package:flutter/material.dart';

class CompletionRateCircle extends StatelessWidget {
  final double percentage; // Від 0.0 до 1.0 (наприклад, 0.75 для 75%)

  const CompletionRateCircle({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Заднє тло (сіре кільце)
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 6,
            color: Colors.white.withOpacity(0.1),
          ),
          // Заповнений прогрес (синє кільце)
          CircularProgressIndicator(
            value: percentage,
            strokeWidth: 6,
            backgroundColor: Colors.transparent,
            color: const Color(0xFF5C85FF), // Твій акцентний колір
            strokeCap: StrokeCap.round, // Заокруглені кінці
          ),
          // Текст всередині
          Center(
            child: Text(
              '${(percentage * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}