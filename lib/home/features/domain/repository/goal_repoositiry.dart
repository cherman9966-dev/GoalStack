import 'package:goalstack/home/features/domain/entities/goal_entity.dart';

abstract class GoalRepository {
  Future<List<GoalEntity>> getAllGoals();

  Future<void> addGoal(GoalEntity goal);

  Future<void> deleteGoal(String id);

  Future<void> updateStreak(String id, int newStreak);
}
