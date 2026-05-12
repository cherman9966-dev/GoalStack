import 'package:flutter/material.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/setting_page_widgets/completion_rate_circle.dart';

class AchievementsSection extends StatelessWidget {
  // 1. ДОДАЄМО ПАРАМЕТРИ ДЛЯ ДИНАМІЧНИХ ДАНИХ
  final int trophiesCount;
  final int firesCount;
  final double completionRate; // Наприклад: 0.78 (для 78%)
  final int bestStreakDays;

  const AchievementsSection({
    super.key,
    required this.trophiesCount,
    required this.firesCount,
    required this.completionRate,
    required this.bestStreakDays,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1, // Твій існуючий розмір карток
          children: [
            // Картка 1: Трофеї
            _buildAchievementCard(
              title: 'Trophy',
              leadingWidget: const Text('🏆', style: TextStyle(fontSize: 24)),
              value: trophiesCount.toString(),
            ),

            // Картка 2: Вогники
            _buildAchievementCard(
              title: 'Fire',
              leadingWidget: const Text('🔥', style: TextStyle(fontSize: 24)),
              value: firesCount.toString(),
            ),

            // Картка 3: Відсоток виконання (передаємо твій віджет у leadingWidget!)
            _buildAchievementCard(
              title: 'Completion Rate',
              leadingWidget: SizedBox(
                width: 24,
                height: 24,
                child: CompletionRateCircle(percentage: completionRate),
              ),
              value: '${(completionRate * 100).toInt()}%',
            ),

            // Картка 4: Найкращий стрік (з підтримкою сірого тексту "days" як у дизайні)
            _buildAchievementCard(
              title: 'Best Streak',
              leadingWidget: const Text('🗓️', style: TextStyle(fontSize: 22)),
              value: bestStreakDays.toString(),
              suffixText: 'days', // Передаємо хвостик
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================================
  // УНІВЕРСАЛЬНИЙ БІЛДЕР КАРТОК (Змінено тільки вирівнювання всередині)
  // =========================================================================
  Widget _buildAchievementCard({
    required String title,
    required Widget leadingWidget, // Тепер приймає Widget (іконку або кружечок)
    required String value,
    String? suffixText, // Необов'язковий текст після цифри (наприклад, "days")
  }) {
    return Container(
      padding: const EdgeInsets.all(16), // Трохи зменшив з 20 до 16, щоб усе ідеально влізло
      decoration: BoxDecoration(
        // ТВІЙ ОРИГІНАЛЬНИЙ ДИЗАЙН ФОНУ (БЕЗ ЗМІН)
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E3A7A).withOpacity(0.8),
            const Color(0xFF122246).withOpacity(0.20),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),

      // НОВА СТРУКТУРА: центрування по вертикалі та горизонталі
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Центрує контент по вертикалі
        crossAxisAlignment: CrossAxisAlignment.center, // Центрує контент по горизонталі
        children: [
          // 1. ЗАГОЛОВОК (Зверху по центру)
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12), // Відступ між заголовком і даними

          // 2. РЯДОК З ІКОНКОЮ ТА ЦИФРОЮ (По центру)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingWidget, // Наша іконка або кружечок прогресу
              const SizedBox(width: 8),

              // Основна велика цифра
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Якщо є приписка "days" (як у Best Streak)
              if (suffixText != null) ...[
                const SizedBox(width: 4),
                Text(
                  suffixText,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}