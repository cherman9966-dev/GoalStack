import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/main.dart';

part 'goal_list_provider.g.dart';

@riverpod
class GoalList extends _$GoalList {
  @override
  List<GoalEntity> build() {
    loadGoals();
    return [];
  }

  Future<void> loadGoals() async {
    final goals = await isar.collection<GoalEntity>().where().findAll();
    state = goals;
  }

  Future<void> addGoal(GoalEntity newGoal) async {
    await isar.writeTxn(() async {
      await isar.collection<GoalEntity>().put(newGoal);
    });

    await loadGoals();
  }

  Future<void> deleteGoal(int id) async {
    await isar.writeTxn(() async {
      await isar.collection<GoalEntity>().delete(id);
    });

    await loadGoals();
  }
}
