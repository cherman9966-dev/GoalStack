import 'package:flutter/material.dart';
import 'package:goalstack/home/features/presentation/widgets/animations/confetti_overlay.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/dynamic_motivator.dart';
import 'package:goalstack/home/features/presentation/widgets/card/logic/streak_calculator.dart';


class GoalCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final int streak;
  final List<bool> initialWeekDays;
  final VoidCallback onDelete;

  const GoalCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.streak,
    required this.initialWeekDays,
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

    _weekDaysStatus = List.from(widget.initialWeekDays);
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
      // Свайп ТІЛЬКИ справа наліво (вліво)

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
                  // Підтвердити
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

      // Якщо підтвердили - викликаємо функцію видалення
      onDismissed: (direction) {
        widget.onDelete();
      },

      // --- САМА КАРТКА ---
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
                Icon(widget.icon, color: widget.iconColor, size: 38),
                const SizedBox(width: 16),

                // Назва цілі
                Expanded(
                  child: Text(
                    widget.title,
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
                      clipBehavior: Clip.none, // Щоб салют міг вилітати за краї
                      children: [
                        // Твоя оригінальна кнопка вогника (без змін)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _weekDaysStatus[index] = !_weekDaysStatus[index];
                            });
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
                                    ? 'assets/icons/flame_icon.png'
                                    : 'assets/icons/flame_gray_icon.png',
                                width: 34, // Розмір іконки
                                height: 34,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        // Анімація, яка лежить рівно поверх кружечка
                        Positioned(
                          left: -20, // Відцентровуємо 80 по відношенню до 40
                          top: -20,
                          child: ConfettiOverlay(
                            playAnimation: _weekDaysStatus[index],
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
    );
  }
}
