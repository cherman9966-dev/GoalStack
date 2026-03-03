import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/data/models/goal_model.dart';
import 'package:goalstack/home/features/data/repositories/goal_repository_impl.dart';
import 'package:goalstack/home/features/presentation/providers/repository_provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:goalstack/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([GoalModelSchema], directory: dir.path);

  final goalRepository = GoalRepositoryImpl(isar);

  runApp(
    ProviderScope(
      overrides: [goalRepositoryProvider.overrideWithValue(goalRepository)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Отримуємо роутер
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Goal Stack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      // Підключаємо GoRouter
      routerConfig: router,
    );
  }
}
