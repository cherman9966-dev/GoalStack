import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'repository_provider.dart';

part 'goal_list_provider.g.dart';

@riverpod
class GoalList extends _$GoalList {
  @override
  Future<List<GoalEntity>> build() async {

    final repository = ref.watch(goalRepositoryProvider);
    return repository.getAllGoals();
  }

// Тут пізніше будуть методи addGoal, deleteGoal тощо
}