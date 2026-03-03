import 'package:flutter/material.dart';
import '../../domain/entities/goal_entity.dart';

class GoalCard extends StatelessWidget {
  final GoalEntity goal;

  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final safeColor = goal.color ?? Colors.black;
    final safeIcon = goal.icon ?? Icons.help_outline;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Заокруглення
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Іконка в кольоровому кружечку
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: goal.color!.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(goal.icon, color: goal.color, size: 28),
          ),
          const SizedBox(width: 16),

          // Назва та прогрес
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Streak: ${goal.streak} days 🔥',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),

          // Стрілочка
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}