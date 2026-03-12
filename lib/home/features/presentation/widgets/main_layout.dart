import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/presentation/widgets/custom_botom_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/calendar')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
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
          SafeArea(bottom: false, child: child),
        ],
      ),

      bottomNavigationBar: CustomBottomBar(
        currentIndex: _calculateSelectedIndex(context),
      ),
    );
  }
}
