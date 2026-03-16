import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Good morning!';
    if (hour >= 12 && hour < 18) return 'Good afternoon!';
    return 'Hi! How did today go?';
  }

  String _getFormattedDate() {
    return DateFormat('EEEE d MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Текст зліва (Вітання + Дата)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _getFormattedDate(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 18,
                ),
              ),
            ],
          ),

          // Кнопка налаштувань справа
          Container(
            margin: const EdgeInsets.only(
              top: 10.0,    // Рухає кнопку ВНИЗ
              right: 0.0,  // Відсуває від правого КРАЮ
              left: 0.0,   // Відсуває ВІД ТЕКСТУ зліва
              bottom: 0.0,  // Можна підняти ВГОРУ (якщо треба)
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.white),
              onPressed: () {
                // TODO: Додати перехід на екран налаштувань
                print("Settings tapped");
              },
            ),
          ),
        ],
      ),
    );
  }
}
