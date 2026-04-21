import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';

class StreakCongratsDialog extends ConsumerStatefulWidget {
  final int goalId;

  const StreakCongratsDialog({super.key, required this.goalId});

  @override
  ConsumerState<StreakCongratsDialog> createState() =>
      _StreakCongratsDialogState();
}

class _StreakCongratsDialogState extends ConsumerState<StreakCongratsDialog>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    // Анімація конфеті
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play();

    // Анімація левітації кубка (з твого HTML)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // Щоб було видно тінь і світіння контейнера
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      // Відступи від країв екрана
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // ОСНОВНЕ ВІКНО ЗГІДНО З ДИЗАЙНОМ
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF122246).withOpacity(0.95),
                  const Color(0xFF091428).withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              // Світіння по краях (glow ефект з HTML)
              border: Border.all(
                color: const Color(0xFFFFD700).withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD700).withOpacity(0.15),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Висота підлаштовується під контент
              children: [
                const Text(
                  'CONGRATS!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'You did it! You successfully completed\nthe entire plan for this week.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),

                // АНІМОВАНИЙ КУБОК
                SizedBox(
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Пульсуюче заднє світіння
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
                                  color: const Color(
                                    0xFFFFD700,
                                  ).withOpacity(0.35),
                                  blurRadius: 45 * value,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Кубок, що плаває
                      AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatAnimation.value),
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/images/fire_cup.png',
                          height: 140,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // СТАТИСТИКА
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Result: ',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    const Text(
                      '7/7 days',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 28),
                    const Text(
                      'Streak: ',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    const Text(
                      '+1 week',
                      style: TextStyle(
                        color: Color(0xFFFF6B00),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // КНОПКА "ПРОДОВЖИТИ"
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFFFF6B00).withOpacity(0.4),
                    ),
                    onPressed: () {
                      ref
                          .read(goalListProvider.notifier)
                          .continueStreak(widget.goalId);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Continue Streak',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // КНОПКА "ЗАВЕРШИТИ"
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF122246),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: () {
                      // ref.read(goalListProvider.notifier).completeGoal(widget.goalId);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Finish & Save',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // КНОПКА "SHARE"
                GestureDetector(
                  onTap: () {
                    print("Share tapped");
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Share Achievement',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // КОНФЕТІ (Падає зверху діалогу)
          Positioned(
            top: -20,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Color(0xFFFF6B00), Colors.yellow, Colors.lightBlue, Colors.green, Colors.blue],
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
