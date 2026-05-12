import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart'; // Перевір шлях
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';

class AchievementsStats {
  final int trophiesCount;
  final int totalFires;
  final int bestStreak;
  final double completionRate;

  AchievementsStats({
    required this.trophiesCount,
    required this.totalFires,
    required this.bestStreak,
    required this.completionRate,
  });
}
final achievementsStatsProvider = FutureProvider<AchievementsStats>((ref) async {
  // 1. Просто "слухаємо" стан списку цілей.
  // Коли список у GoalList зміниться, аналітика оновиться АВТОМАТИЧНО.
  final List<GoalEntity> allGoals = ref.watch(goalListProvider);



  // =========================================================
  // Твоя логіка підрахунку (використовуємо 'allGoals')
  // =========================================================

  // 🔥 ВСЬОГО ВОГНИКІВ
  int totalFires = 0;
  for (var goal in allGoals) {
    totalFires += goal.totalFiresInsideGoal;
  }

  // 🏆 КУБКИ (Perfect Goals)
  int trophies = 0;
  for (var goal in allGoals) {
    if (goal.isCompleted) {
      // Визначаємо ціль (наприклад, 21 день або custom)
      int target = goal.goalType == 'custom_amount' ? goal.customTargetDays : 21;
      if (goal.streak >= target) trophies++;
    }
  }

  // ⚡ BEST STREAK
  int bestStreak = 0;
  if (allGoals.isNotEmpty) {
    bestStreak = allGoals.map((g) => g.streak).reduce((a, b) => a > b ? a : b);
  }

  // 📊 PROGRESS (Кругова шкала)
  double completionRate = 0.0;
  final activeGoals = allGoals.where((g) => !g.isCompleted).toList();
  if (activeGoals.isNotEmpty) {
    final today = DateTime.now();
    int finishedToday = activeGoals.where((goal) =>
        goal.completedDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day
        )
    ).length;
    completionRate = finishedToday / activeGoals.length;
  }

  return AchievementsStats(
    trophiesCount: trophies,
    totalFires: totalFires,
    bestStreak: bestStreak,
    completionRate: completionRate,
  );
});