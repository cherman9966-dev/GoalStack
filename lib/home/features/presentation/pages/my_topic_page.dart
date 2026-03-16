import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/settings/main_layout.dart';
import 'empty_topic_screen.dart';
import '../widgets/card/goal_card.dart';


// ❗️ 1. Змінили на ConsumerStatefulWidget
class MyTopicPage extends ConsumerStatefulWidget {
  const MyTopicPage({super.key});

  @override
  ConsumerState<MyTopicPage> createState() => _MyTopicPageState();
}

// ❗️ 2. Змінили на ConsumerState
class _MyTopicPageState extends ConsumerState<MyTopicPage> {
  // Наші тестові цілі
  List<Map<String, dynamic>> dummyGoals = [
    {
      'title': 'Wake up at 7am everyday',
      'icon': Icons.alarm,
      'color': const Color(0xFF0084F4),
      'streak': 4,
      'days': [true, false, true, true, true, true, false],
    },
    {
      'title': 'Read 20 pages of a book',
      'icon': Icons.menu_book,
      'color': const Color(0xFFFF6B00),
      'streak': 12,
      'days': [false, false, false, false, false, false, false],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ❗️ 3. МАГІЯ ТУТ: Ми автоматично перемикаємо Riverpod!
    // Якщо список НЕ пустий -> true (меню показується)
    // Якщо пустий -> false (меню ховається)
    Future.microtask(() {
      ref.read(hasGoalsProvider.notifier).state = dummyGoals.isNotEmpty;
    });

    // Якщо цілей немає - малюємо пустий екран з помаранчевою кнопкою
    if (dummyGoals.isEmpty) {
      return const EmptyTopicScreen();
    }

    // Якщо цілі є - малюємо список
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false, // ❗️ Вимикаємо нижню безпечну зону для нашого відступу
        child: ListView.builder(
          // ❗️ Ті самі відступи, щоб картки скролилися МІЖ менюшками
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 80.0,
            bottom: 120.0,
          ),
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
                setState(() {
                  dummyGoals.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Goal deleted successfully'),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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