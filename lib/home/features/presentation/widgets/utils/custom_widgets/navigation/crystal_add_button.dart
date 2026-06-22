import 'package:flutter/material.dart';

class CustomCrystalButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size; // Загальний розмір кнопки (ширина і висота)
  final double iconSize; // Розмір іконки плюса всередині

  const CustomCrystalButton({
    super.key,
    required this.onTap,
    this.size = 65.0, // Дефолтний розмір, якщо не передано інший
    this.iconSize = 28.0, // Дефолтний розмір іконки
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Робимо всю область SizedBox чутливою до тапу, включаючи прозорі пікселі
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Шар 1: Твоє згенероване зображення кристала
            Image.asset(
              'assets/icons/crystall_add_button.png',
              // Переконайся, що шлях збігається з pubspec.yaml
              width: size,
              height: size,
              fit: BoxFit.contain,
            ),

            // Шар 2: Іконка плюса
            // Використання коду для іконки поверх картинки дозволяє гнучко міняти колір/розмір
            Icon(
              Icons.add,
              color: const Color(0xFF5A5A5A),
              // Темно-сірий колір, як у дизайні текстури
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
