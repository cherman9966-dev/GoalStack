import 'package:flutter/material.dart';

class PrimaryGradientButton extends StatelessWidget {
  // Ці змінні роблять кнопку універсальною
  final String text;
  final VoidCallback onPressed; // Тип для функції, яка нічого не повертає

  const PrimaryGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE65C00), // Насичений темний
            Color(0xFFFF7A1A), // Яскравий помаранчевий
            Color(0xFFFFC700), // Жовтий
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7A1A).withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        // ❗️ ТУТ МИ ВИКОРИСТОВУЄМО ПЕРЕДАНУ ФУНКЦІЮ ❗️
        onPressed: onPressed,
        // ❗️ ТУТ МИ ВИКОРИСТОВУЄМО ПЕРЕДАНИЙ ТЕКСТ ❗️
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}