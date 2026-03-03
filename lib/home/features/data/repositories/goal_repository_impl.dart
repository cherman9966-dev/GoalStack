import 'package:flutter/material.dart';
import 'package:goalstack/home/features/domain/repository/goal_repoositiry.dart';
import 'package:isar/isar.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/home/features/data/models/goal_model.dart';

class GoalRepositoryImpl implements GoalRepository {
  final Isar isar;

  GoalRepositoryImpl(this.isar);

  @override
  Future<List<GoalEntity>> getAllGoals() async {
    final models = await isar.goalModels.where().findAll();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addGoal(GoalEntity goal) async {
    final model = GoalModel()
      ..title = goal.title
      ..streak = goal.streak
      ..iconCodePoint = goal.icon?.codePoint ?? Icons.help_outline.codePoint
      ..colorValue = goal.color?.value ?? Colors.black.value
      ..createdAt = goal.createdAt;

    await isar.writeTxn(() async {
      await isar.goalModels.put(model);
    });
  }

  @override
  Future<void> deleteGoal(String id) async {
    await isar.writeTxn(() async {
      await isar.goalModels.delete(int.parse(id));
    });
  }

  @override
  Future<void> updateStreak(String id, int newStreak) async {
    await isar.writeTxn(() async {
      final model = await isar.goalModels.get(int.parse(id));
      if (model != null) {
        model.streak = newStreak;
        await isar.goalModels.put(model);
      }
    });
  }
}
