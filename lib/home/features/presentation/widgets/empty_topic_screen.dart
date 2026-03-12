import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTopicsWidget extends StatelessWidget {
  const EmptyTopicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Expanded розтягне цей блок, щоб він був рівно по центру екрану
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Іконка вогника
            SvgPicture.asset(
              'assets/icons/ic_flame_outline.svg', // ЗАМІНИ НА СВОЮ НАЗВУ ФАЙЛУ
              height: 120,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 24),

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
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B00), // Помаранчевий
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO: Відкрити форму створення нової цілі
                  print("Create topic tapped");
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
