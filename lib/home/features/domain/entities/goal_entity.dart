import 'package:flutter/material.dart';

class GoalEntity {
  final String id;
  final String title;
  final int streak;
  final bool isCompleted;
  final DateTime createdAt;
  final IconData? icon;
  final Color? color;

  const GoalEntity({
    required this.id,
    required this.title,
    this.streak = 0,
    this.isCompleted = false,
    required this.createdAt,
    this.icon,
    this.color,
  });
}
