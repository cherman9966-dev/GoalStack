import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(index);
            },
            elevation: 0,
            backgroundColor: Colors.orange.withOpacity(0.6),
            selectedItemColor: Colors.black,
            selectedIconTheme: const IconThemeData(opacity: 1.0, size: 30),
            unselectedItemColor: Colors.grey[600],
            unselectedIconTheme: const IconThemeData(opacity: 0.6, size: 24),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'My Topics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
