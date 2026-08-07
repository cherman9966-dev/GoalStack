import 'package:flutter/material.dart';

class CompletionRateCircle extends StatelessWidget {
  final double percentage; // Від 0.0 до 1.0 (наприклад, 0.75 для 75%)

  const CompletionRateCircle({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        value: percentage.clamp(0.0, 1.0),
        strokeWidth: 4.0, // Оптимальна товщина для невеликого розміру
        backgroundColor: const Color(0xFF2A3B61),
        color: const Color(0xFF52B774),
        strokeCap: StrokeCap.round,
      ),
    );
  }
}