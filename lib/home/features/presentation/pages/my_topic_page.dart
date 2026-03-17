import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';
import 'package:goalstack/settings/main_layout.dart';
import 'empty_topic_screen.dart';
import '../widgets/card/goal_card.dart';

class MyTopicPage extends ConsumerStatefulWidget {
  const MyTopicPage({super.key});

  @override
  ConsumerState<MyTopicPage> createState() => _MyTopicPageState();
}

class _MyTopicPageState extends ConsumerState<MyTopicPage> {
  @override
  Widget build(BuildContext context) {
    final goals = ref.watch(goalListProvider);

    Future.microtask(() {
      ref.read(hasGoalsProvider.notifier).state = goals.isNotEmpty;
    });

    if (goals.isEmpty) {
      return const EmptyTopicScreen();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: ListView.builder(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 80.0,
            bottom: 120.0,
          ),
          itemCount: goals.length,
          itemBuilder: (context, index) {
            final goal = goals[index];

            return GoalCard(
              title: goal.title,

              icon: goal.icon ?? Icons.flag,
              iconColor: goal.color ?? Colors.blue,

              streak: goal.streak,
              initialWeekDays: goal.weekDaysStatus,

              // Вогники з бази
              onDelete: () {
                ref.read(goalListProvider.notifier).deleteGoal(goal.id);

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
