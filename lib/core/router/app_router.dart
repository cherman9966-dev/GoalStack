import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/presentation/home_page.dart';
import 'package:goalstack/home/features/presentation/screen/callendar_page.dart';
import 'package:goalstack/home/features/presentation/screen/setting_page.dart';
import 'package:goalstack/home/features/presentation/screen/my_topics_page.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home_page',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home_page',
              builder: (context, state) => const MyTopicsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',
              builder: (context, state) => const CallendarPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
