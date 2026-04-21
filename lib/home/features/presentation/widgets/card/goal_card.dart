import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/dynamic_motivator.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/streak_calculator.dart';
import 'package:goalstack/home/features/presentation/widgets/dialogs/streak_congrats_dialog.dart';


class GoalCard extends StatefulWidget {
  final GoalEntity goal;
  final VoidCallback onDelete; // Залишаємо тільки дії (callback), яких немає в моделі

  const GoalCard({
    super.key,
    required this.goal,
    required this.onDelete,
  });

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  late List<bool> _weekDaysStatus;
  final List<String> _dayNames = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

  @override
  void initState() {
    super.initState();

    _weekDaysStatus = List.from(widget.goal.weekDaysStatus);
  }

  @override
  Widget build(BuildContext context) {
    final int activeFires = _weekDaysStatus.where((isCompleted) => isCompleted).length;
    final bool isPerfectWeek = activeFires == 7;
    final int liveStreak = StreakCalculator.calculate(_weekDaysStatus);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.2,
      },

      // Фон, який видно під час свайпу (Червоний з корзиною)
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 32),
      ),

      // Вікно ПІДТВЕРДЖЕННЯ видалення
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A2A4A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Delete Goal?',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Are you sure you want to delete this goal? This action cannot be undone.',
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  // Скасувати
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            );
          },
        );
      },

      onDismissed: (direction) {
        widget.onDelete();
      },

      // --- САМА КАРТКА ---
      // Обгортаємо всю картку
      child: GestureDetector(
        // behavior: HitTestBehavior.opaque гарантує, що клік спрацює навіть на порожньому місці між текстом
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // ❗️ ВАЖЛИВО: Переконайся, що у тебе в конструкторі GoalCard є поле final GoalEntity goal;
          // Якщо так, ми просто передаємо цей об'єкт на екран редагування
          context.push('/add_goal', extra: widget.goal);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF122246).withOpacity(0.45),
                const Color(0xFF091428).withOpacity(0.45),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.18)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. ВЕРХНІЙ РЯДОК
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Іконка заданого кольору
                  // (Якщо ти змінив конструктор на widget.goal, то тут буде widget.goal.icon)
                  Icon(widget.goal.icon, color: widget.goal.color, size: 38),
                  const SizedBox(width: 16),

                  // Назва цілі
                  Expanded(
                    child: Text(
                      widget.goal.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Текст Streak
                      Text(
                        '$liveStreak days streak!',
                        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
                      ),
                      const SizedBox(height: 2),

                      DynamicMotivator(activeFires: activeFires),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. НИЖНІЙ РЯДОК: Вогники
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final bool isCompleted = index < _weekDaysStatus.length
                      ? _weekDaysStatus[index]
                      : false;
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Це твій ВНУТРІШНІЙ GestureDetector (він має пріоритет при натисканні сюди)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _weekDaysStatus[index] = !_weekDaysStatus[index];
                              });
                              final isAllDaysCompleted = _weekDaysStatus.every((status) => status == true);
                              if (isAllDaysCompleted) {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black.withOpacity(0.6),
                                  builder: (context) {
                                    return StreakCongratsDialog(goalId: widget.goal.id); // Або widget.goal.id
                                  },
                                );
                              }
                            },
                            child: Container(
                              width: 43,
                              height: 43,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
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
                        ],
                      ),

                      const SizedBox(height: 8),
                      // Назва дня
                      Text(
                        _dayNames[index],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
