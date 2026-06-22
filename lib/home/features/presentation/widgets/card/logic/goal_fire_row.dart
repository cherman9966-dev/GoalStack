import 'package:flutter/material.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';

class GoalFiresRow extends StatelessWidget {
  final GoalEntity goal;
  final List<bool> weekDaysStatus;
  final Function(int index) onFireTapped;

  const GoalFiresRow({
    super.key,
    required this.goal,
    required this.weekDaysStatus,
    required this.onFireTapped,
  });

  // Малюємо один вогник
  Widget _buildSingleFire(int index, String? label) {
    // Перевіряємо статус (захист від помилок індексів)
    final bool isCompleted = index < weekDaysStatus.length ? weekDaysStatus[index] : false;

    return Column(
      mainAxisSize: MainAxisSize.min, // Щоб колонка займала мінімум місця
      children: [
        // Твій красивий дизайн вогника
        GestureDetector(
          onTap: () => onFireTapped(index), // ❗️ Передаємо ТІЛЬКИ індекс наверх
          child: Container(
            width: 43,
            height: 43,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                isCompleted
                    ? 'assets/icons/fire_flame.png'
                    : 'assets/icons/grey_fire.png',
                width: 34,
                height: 34,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        // Назва дня (якщо вона є)
        if (label != null) ...[
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Той самий світчер, але тепер він гарно живе у власному файлі
    switch (goal.goalType) {

      case 'custom':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(goal.customTargetDays, (index) {
            return _buildSingleFire(index, null);
          }),
        );

      case 'calendar':
        final List<String> allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        List<String> activeLabels = [];
        for (int i = 0; i < 7; i++) {
          if (goal.calendarSelectedDays.length > i && goal.calendarSelectedDays[i]) {
            activeLabels.add(allDays[i]);
          }
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(activeLabels.length, (index) {
            return _buildSingleFire(index, activeLabels[index]);
          }),
        );

      case 'all_days':
      default:
        final List<String> defaultDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            return _buildSingleFire(index, defaultDays[index]);
          }),
        );
    }
  }
}