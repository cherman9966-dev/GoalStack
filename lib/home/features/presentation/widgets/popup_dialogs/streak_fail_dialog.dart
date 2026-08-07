import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/primary_gradient_button.dart';

class GoalFailPopup extends ConsumerStatefulWidget {
  final int goalId;
  final int completedDays; // Кількість днів, які вдалось виконати (наприклад, 4)
  final int targetDays;    // Скільки треба було (наприклад, 7)

  const GoalFailPopup({
    super.key,
    required this.goalId,
    required this.completedDays,
    required this.targetDays,
  });

  @override
  ConsumerState<GoalFailPopup> createState() => _GoalFailPopupState();
}

class _GoalFailPopupState extends ConsumerState<GoalFailPopup> with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    // Налаштовуємо контролер для плаваючої анімації (вгору-вниз)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // ОСНОВНЕ ВІКНО ЗГІДНО З ДИЗАЙНОМ
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            decoration: BoxDecoration(
              // Холодніший темний градієнт поразки
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF122246).withOpacity(0.95),
                  const Color(0xFF050B14).withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              // Червоно-синє світіння по краях замість золотого
              border: Border.all(
                color: Colors.redAccent.withOpacity(0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.15), // Тінь світіння
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Streak broken',
                  style: TextStyle(
                    fontSize: 28, // Трохи менше для довгого слова, щоб влізло
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),

                const Text(
                  'Time is up, but you didn\'t reach the goal.\nDon\'t give up, consistency takes practice!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),

                // АНІМОВАНА ПРОВАЛЬНА ІКОНКА (Плаваюча)
                SizedBox(
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Пульсуюче заднє світіння (червонувате/холодне)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1.1),
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Container(
                            width: 140 * value,
                            height: 140 * value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent.withOpacity(0.25),
                                  blurRadius: 45 * value,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Іконка, що плаває (додай свою картинку розбитого серця/стріку)
                      AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatAnimation.value),
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/images/sad_fire.png', // ЗАМІНИ НА СВОЮ ІКОНКУ
                          height: 150, // Трохи менша за кубок для акуратності
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // СТАТИСТИКА (Показуємо скільки вдалось пройти)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Completed: ',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    Text(
                      '${widget.completedDays}/${widget.targetDays} days',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 24),
                    const Text(
                      'Result: ',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    const Text(
                      'Failed',
                      style: TextStyle(
                        color: Colors.redAccent, // Акцент на статусі
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // КНОПКА "СПРОБУВАТИ ЗНОВУ" (Використовуємо твою градієнтну)
                PrimaryGradientButton(
                  text: 'Try Again',
                  onPressed: () {
                    // Викликаємо логіку перезапуску цілі
                    ref.read(goalListProvider.notifier).restartGoal(widget.goalId);
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 16),

                // КНОПКА "СКАСУВАТИ / ЗАКРИТИ" (Біла кнопка з оригіналу)
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.8)),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: () {
                      // Просто закриваємо вікно, залишаючи ціль як є (або видаляємо)
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}