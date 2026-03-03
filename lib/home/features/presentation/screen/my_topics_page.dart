import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/providers/goal_list_provider.dart';
import '../widgets/goal_card.dart'; // Твій віджет картки

// class MyTopicsPage extends StatefulWidget {
//   const MyTopicsPage({super.key});
//
//   @override
//   State<MyTopicsPage> createState() => _MyTopicsPageState();
// }

class MyTopicsPage extends ConsumerWidget {
  const MyTopicsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Streak',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blueGrey, Colors.grey]),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.list, color: Colors.black, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: goalsAsync.when(
        // Поки вантажиться
        loading: () => const Center(child: CircularProgressIndicator()),

        // Якщо помилка
        error: (error, stack) => Center(child: Text('Помилка: $error')),

        // Коли дані є
        data: (goals) {
          if (goals.isEmpty) {
            return const Center(child: Text("Ще немає цілей. Додай першу!"));
          }
          // Малюємо список
          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              return GoalCard(goal: goal);
            },
          );
        },
      ),
      // Кнопка додавання
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Натиснули додати");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
