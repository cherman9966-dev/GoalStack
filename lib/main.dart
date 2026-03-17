import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/data/repositories/goal_repository_impl.dart';
import 'package:goalstack/home/features/presentation/providers/repository_provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:goalstack/core/router/app_router.dart';
import 'home/features/domain/entities/goal_entity.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  isar = await Isar.open([GoalEntitySchema], directory: dir.path);

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
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Goal Stack',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        canvasColor: const Color(0xFF000000),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
          surface: const Color(0xFF000000),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
