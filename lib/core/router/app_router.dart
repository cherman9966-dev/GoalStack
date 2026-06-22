import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';
import 'package:goalstack/home/features/presentation/pages/add_goal_page.dart';
import 'package:goalstack/home/features/presentation/pages/calendar_page.dart';
import 'package:goalstack/home/features/presentation/pages/login_page.dart';
import 'package:goalstack/home/features/presentation/pages/my_topic_page.dart';
import 'package:goalstack/home/features/presentation/pages/setting_page.dart';
import 'package:goalstack/home/features/presentation/pages/artifacts_page.dart';
import 'package:goalstack/settings/main_layout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login_page',
    routes: [
      GoRoute(
        path: '/login_page',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/add_goal',
        builder: (context, state) {
          final goal = state.extra as GoalEntity?;
          return AddGoalPage(goalToEdit: goal);
        },
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SettingPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/my_topic_page',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MyTopicPage(),
            ),
          ),
          GoRoute(
            path: '/calendar',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CalendarPage(),
            ),
          ),
          GoRoute(
            path: '/artifacts',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ArtifactsCollection(),
            ),
          ),
        ],
      ),
    ],
  );
});
