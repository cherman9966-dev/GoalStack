import 'package:flutter/material.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';

class GoalCard extends StatelessWidget {
  final GoalEntity goal;

  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Icon(goal.icon, color: goal.color, size: 30),
          const SizedBox(width: 15),
          Text(
            goal.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text('${goal.streak}🔥'),
        ],
      ),
    );
  }
}
