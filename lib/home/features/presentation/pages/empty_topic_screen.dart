import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyTopicScreen extends StatelessWidget {
  const EmptyTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Прибрали Expanded, додали Padding, щоб кнопка не прилипала до країв
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ❗️ Використовуємо Image.asset для PNG
            Image.asset(
              'assets/icons/vector_flame.png', // Перевір, чи правильна назва!
              height: 140,
              // Ось так робиться напівпрозорий білий колір поверх PNG у Flutter:
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.srcIn,
            ),
            const SizedBox(height: 28),

            // Текст
            const Text(
              'Create a topic and check in with\none tap.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),

            // Кнопка "Створити"
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B00), // Твій помаранчевий
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // ❗️ МІГРАЦІЯ: Відкриваємо екран створення цілі
                  context.push('/add_goal');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Create first topic',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}