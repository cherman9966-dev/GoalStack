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
    
    // Перевірка на провалені цикли при завантаженні
    final DateTime now = DateTime.now();
    bool needsReload = false;

    for (var goal in goals) {
      if (goal.isDeleted || goal.isCompleted) continue;

      // Визначаємо, чи завершився цикл (наприклад, пройшов тиждень з моменту створення або останнього скидання)
      // Для простоти: якщо сьогодні понеділок, а вогники за минулий тиждень ще не скинуті і не заповнені
      final bool isNewWeek = now.weekday == 1 && goal.createdAt.weekday != 1; // Спрощена логіка
      
      // Більш точна логіка: якщо з моменту створення пройшло більше днів, ніж розмір weekDaysStatus
      final int daysSinceCreation = now.difference(goal.createdAt).inDays;
      final bool cycleOver = daysSinceCreation >= goal.weekDaysStatus.length;
      final bool isNotPerfect = goal.weekDaysStatus.contains(false);

      if (cycleOver && isNotPerfect) {
        // Ми не скидаємо автоматично, а просто даємо системі знати, що ця ціль "чекає" на попап провалу
        // Або можемо позначити її спеціальним статусом
      }
    }

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
    final goal = await isar.goalEntitys.get(id);
    if (goal != null) {
      await isar.writeTxn(() async {
        goal.isDeleted = true;
        await isar.goalEntitys.put(goal);
      });
      await loadGoals();
    }
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
        goal.streak += 1; // Додаємо останній успішний тиждень у скарбничку
        goal.isCompleted = true;
        await isar.goalEntitys.put(goal);
      });
      await loadGoals();
    }
  }

  Future<void> restartGoal(int goalId) async {
    final goal = await isar.goalEntitys.get(goalId);
    if (goal != null) {
      await isar.writeTxn(() async {
        goal.streak = 0; // Скидаємо загальний стрік при провалі
        goal.weekDaysStatus = List.filled(goal.weekDaysStatus.length, false);
        goal.createdAt = DateTime.now(); // Оновлюємо дату старту циклу
        await isar.goalEntitys.put(goal);
      });
      await loadGoals();
    }
  }

  Future<void> resetAllProgress() async {
    final goals = await isar.goalEntitys.where().findAll();
    await isar.writeTxn(() async {
      for (var goal in goals) {
        goal.streak = 0;
        goal.totalFiresInsideGoal = 0;
        goal.weekDaysStatus = List.filled(goal.weekDaysStatus.length, false);
        goal.completedDates = [];
        goal.isCompleted = false;
        await isar.goalEntitys.put(goal);
      }
    });
    await loadGoals();
  }
}

@riverpod
bool hasActiveGoals(ref) {
  final goals = ref.watch(goalListProvider);
  return goals.any((g) => !g.isDeleted);
}
