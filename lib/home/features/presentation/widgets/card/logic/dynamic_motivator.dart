import 'package:flutter/material.dart';

class DynamicMotivator extends StatelessWidget {
  final int activeFires; // Приймаємо кількість вогників ззовні

  const DynamicMotivator({super.key, required this.activeFires});

  @override
  Widget build(BuildContext context) {
    // 1. Якщо ідеальний тиждень - малюємо золоту плашку
    if (activeFires == 7) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.amberAccent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amberAccent.withOpacity(0.5)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('100%', style: TextStyle(color: Colors.amberAccent, fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Icon(Icons.emoji_events, color: Colors.amberAccent, size: 18),
          ],
        ),
      );
    }

    // 2. Якщо не 7, визначаємо текст
    String motivatorText;
    if (activeFires == 0) {
      motivatorText = "Time to do!";
    } else if (activeFires <= 2) {
      motivatorText = "Nice start!";
    } else if (activeFires <= 4) {
      motivatorText = "Good job!";
    } else {
      motivatorText = "The best!";
    }

    // 3. Повертаємо звичайний текст
    return Text(
      motivatorText,
      style: const TextStyle(
        color: Color(0xFFFF6B00),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}