import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/presentation/home_page.dart';
import 'package:goalstack/home/features/presentation/screen/callendar_page.dart';
import 'package:goalstack/home/features/presentation/screen/setting_page.dart';
import 'package:goalstack/home/features/presentation/screen/my_topics_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
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
});
