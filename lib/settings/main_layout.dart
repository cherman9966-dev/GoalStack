import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/widgets/custom_botom_bar.dart';
import 'package:goalstack/home/features/presentation/widgets/home_app_bar.dart';

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
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/main_background2.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: child,
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: const HomeAppBar()),
          ),
        ],
      ),
      bottomNavigationBar: hasGoals ?CustomBottomBar(
        currentIndex: _calculateSelectedIndex(context),
      )
      :null,
    );
  }
}
