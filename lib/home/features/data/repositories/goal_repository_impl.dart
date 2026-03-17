import 'package:goalstack/home/features/domain/repository/goal_repoositiry.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/goal_entity.dart';

class GoalRepositoryImpl implements GoalRepository {
  final Isar isar;

  GoalRepositoryImpl(this.isar);

  @override
  Future<List<GoalEntity>> getAllGoals() async {
    return await isar.goalEntitys.where().findAll();
  }

  @override
  Future<void> addGoal(GoalEntity goal) async {
    await isar.writeTxn(() async {
      await isar.goalEntitys.put(goal);
    });
  }

  @override
  Future<void> deleteGoal(String id) async {
    await isar.writeTxn(() async {
      await isar.goalEntitys.delete(int.parse(id));
    });
  }

  @override
  Future<void> updateStreak(String id, int newStreak) async {
    await isar.writeTxn(() async {
      final goal = await isar.goalEntitys.get(int.parse(id));
      if (goal != null) {
        goal.streak = newStreak;
        await isar.goalEntitys.put(goal);
      }
    });
  }
}
