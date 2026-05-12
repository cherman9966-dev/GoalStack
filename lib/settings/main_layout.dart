import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/custom_botom_bar.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/home_app_bar.dart';

final hasGoalsProvider = StateProvider<bool>((ref) => false);

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/calendar')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasGoals = ref.watch(hasGoalsProvider);

    // 1. Визначаємо, чи ми зараз на сторінці налаштувань
    final String location = GoRouterState.of(context).uri.path;
    final bool isSettingsPage = location.startsWith('/settings');

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Твій спільний фон для всього додатка
          Positioned.fill(
            child: Image.asset(
              'assets/images/log_background_fon.png',
              fit: BoxFit.cover,
            ),
          ),

          // Основний контент (сторінки)
          Positioned.fill(
            child: SafeArea(
              // Якщо це налаштування, ми не хочемо SafeArea зверху,
              // бо там буде свій AppBar. Якщо головна — залишаємо як було.
              bottom: false,
              top: !isSettingsPage,
              child: child,
            ),
          ),

          // 2. ПОКАЗУЄМО HomeAppBar тільки якщо це НЕ сторінка налаштувань
          if (!isSettingsPage)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: const SafeArea(child: HomeAppBar()),
            ),
        ],
      ),
      // 3. ПРИХОВУЄМО BottomBar на сторінці налаштувань
      bottomNavigationBar: (hasGoals && !isSettingsPage)
          ? CustomBottomBar(
        currentIndex: _calculateSelectedIndex(context),
      )
          : null,
    );
  }
}