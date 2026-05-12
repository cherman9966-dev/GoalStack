import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart'; // Перевір шлях
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/streak_calculator.dart';

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
  final List<GoalEntity> allGoals = ref.watch(goalListProvider);
  int totalFires = 0;
  for (var goal in allGoals) {
    totalFires += goal.totalFiresInsideGoal;
  }

  int trophies = 0;
  for (var goal in allGoals) {
    trophies += goal.streak;
  }

  // ⚡ BEST STREAK
  int bestStreak = 0;
  for (var goal in allGoals) {
    int targetCount = 7;
    if (goal.goalType == 'custom') {
      targetCount = goal.customTargetDays;
    } else if (goal.goalType == 'calendar') {
      targetCount = goal.calendarSelectedDays.where((day) => day == true).length;
    }
    // Якщо ціль завершена, її поточні вогники вже враховані в streak, тому liveStreak = 0
    int liveStreak = goal.isCompleted ? 0 : StreakCalculator.calculate(goal.weekDaysStatus);
    // Загальний стрік = (кількість завершених циклів * дні в циклі) + поточні дні
    int totalStreak = (goal.streak * targetCount) + liveStreak;

    if (totalStreak > bestStreak) {
      bestStreak = totalStreak;
    }
  }

  // 📊 PROGRESS (Кругова шкала) - Середній прогрес по всіх активних цілях
  double completionRate = 0.0;
  final activeGoals = allGoals.where((g) => !g.isCompleted && !g.isDeleted).toList();
  
  if (activeGoals.isNotEmpty) {
    double totalProgressSum = 0.0;
    for (var goal in activeGoals) {
      // Кількість запалених вогників у поточному циклі
      int litFires = goal.weekDaysStatus.where((status) => status == true).length;
      // Загальна кількість вогників у циклі
      int totalFiresInCycle = goal.weekDaysStatus.length;
      
      if (totalFiresInCycle > 0) {
        totalProgressSum += (litFires / totalFiresInCycle);
      }
    }
    // Середнє значення прогресу (від 0.0 до 1.0)
    completionRate = totalProgressSum / activeGoals.length;
  }

  return AchievementsStats(
    trophiesCount: trophies,
    totalFires: totalFires,
    bestStreak: bestStreak,
    completionRate: completionRate,
  );
});