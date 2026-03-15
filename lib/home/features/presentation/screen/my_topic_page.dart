import 'package:flutter/material.dart';
import 'package:goalstack/home/features/presentation/widgets/empty_topic_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/widgets/goal_card.dart';
import 'package:goalstack/settings/main_layout.dart';

class MyTopicPage extends StatefulWidget {
  const MyTopicPage({super.key});

  @override
  State<MyTopicPage> createState() => _MyTopicPageState();
}

class _MyTopicPageState extends State<MyTopicPage> {
  // Тимчасовий список для тестування дизайну
  List<Map<String, dynamic>> dummyGoals = [
    {
      'title': 'Wake up at 7am everyday',
      'icon': Icons.alarm,
      'color': const Color(0xFF0084F4), // Синій
      'streak': 4,
      'days': [true, false, true, true, true, true, false],
    },
    {
      'title': 'Read 20 pages of a book',
      'icon': Icons.menu_book,
      'color': const Color(0xFFFF6B00), // Помаранчевий
      'streak': 12,
      'days': [false, false, false, false, false, false, false],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Якщо список пустий - показуємо екран створення
    if (dummyGoals.isEmpty) {
      return const EmptyTopicScreen();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          itemCount: dummyGoals.length,
          itemBuilder: (context, index) {
            final goal = dummyGoals[index];

            return GoalCard(
              title: goal['title'],
              icon: goal['icon'],
              iconColor: goal['color'],
              streak: goal['streak'],
              initialWeekDays: List<bool>.from(goal['days']),
              onDelete: () {
                // Логіка видалення після підтвердження свайпу
                setState(() {
                  dummyGoals.removeAt(index);
                });

                // Показуємо плашку, що ціль видалено
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Goal deleted successfully'),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
