import 'package:goalstack/core/utils/day_extensions.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/main.dart';

part 'goal_list_provider.g.dart';

@Riverpod(keepAlive: true)
class GoalList extends _$GoalList {
  @override
  List<GoalEntity> build() {
    loadGoals();
    return [];
  }

  Future<void> loadGoals() async {
    final goals = await isar.goalEntitys.where().findAll();
    state = goals;
  }

  Future<void> addGoal(GoalEntity newGoal) async {
    await isar.writeTxn(() async {
      await isar.goalEntitys.put(newGoal);
    });
    await loadGoals();
  }

  Future<void> updateGoal(GoalEntity updatedGoal) async {
    final DateTime today = DateTime.now().dateOnly;

    // =========================================================================
    // 1. ЛОГІКА ЗАГАЛЬНОГО РАХУНКУ ВОГНИКІВ (НЕЗАЛЕЖНО ВІД ДАТИ)
    // =========================================================================
    // Читаємо стару версію цілі з бази, щоб побачити точну різницю кліків
    final oldGoal = await isar.goalEntitys.get(updatedGoal.id);

    // Рахуємо скільки вогників (true) було раніше і скільки стало зараз
    final int oldFiresCount = oldGoal?.weekDaysStatus.where((status) => status).length ?? 0;
    final int newFiresCount = updatedGoal.weekDaysStatus.where((status) => status).length;

    if (newFiresCount > oldFiresCount) {
      // Якщо ти натиснув новий вогник (навіть кілька в один день),
      // додаємо цю різницю до нашого незалежного лічильника
      updatedGoal.totalFiresInsideGoal += (newFiresCount - oldFiresCount);
    } else if (newFiresCount < oldFiresCount) {
      // Якщо ти "віджав" вогник назад, віднімаємо, щоб статистика була чесною
      updatedGoal.totalFiresInsideGoal -= (oldFiresCount - newFiresCount);
      // Захист від від'ємних чисел
      if (updatedGoal.totalFiresInsideGoal < 0) {
        updatedGoal.totalFiresInsideGoal = 0;
      }
    }

    // =========================================================================
    // 2. СТАРА ЛОГІКА ДАТ ДЛЯ САМОЇ КАРТКИ ЦІЛІ (БЕЗ ЗМІН)
    // =========================================================================
    final bool hasAnySuccessToday = updatedGoal.weekDaysStatus.contains(true);

    if (hasAnySuccessToday) {
      if (!updatedGoal.completedDates.contains(today)) {
        updatedGoal.completedDates.add(today);
      }
    } else {
      updatedGoal.completedDates.removeWhere((date) =>
      date.year == today.year &&
          date.month == today.month &&
          date.day == today.day
      );
    }

    // Зберігаємо оновлену ціль у базу
    await isar.writeTxn(() async {
      await isar.goalEntitys.put(updatedGoal);
    });

    await loadGoals();
  }

  Future<void> deleteGoal(int id) async {
    await isar.writeTxn(() async {
      await isar.goalEntitys.delete(id);
    });
    await loadGoals();
  }

  Future<void> continueStreak(int goalId) async {
    final goal = await isar.goalEntitys.get(goalId);
    if (goal != null) {
      await isar.writeTxn(() async {
        goal.streak += 1;
        goal.weekDaysStatus = List.filled(goal.weekDaysStatus.length, false);
        await isar.goalEntitys.put(goal);
      });
      await loadGoals();
    }
  }

  // В файлі goal_list_provider.dart

  Future<void> completeGoal(int goalId) async {
    final goal = await isar.goalEntitys.get(goalId);
    if (goal != null) {
      await isar.writeTxn(() async {
        goal.isCompleted = true;
        await isar.goalEntitys.put(goal);
      });
      await loadGoals();
    }
  }
}
