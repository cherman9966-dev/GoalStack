import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/presentation/screen/my_topic_page.dart';
import 'package:goalstack/home/features/presentation/screen/callendar_page.dart';
import 'package:goalstack/home/features/presentation/screen/setting_page.dart';
import 'package:goalstack/home/features/presentation/widgets/main_layout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/my_topic_page',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/my_topic_page',
            builder: (context, state) => const MyTopicPage(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CallendarPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingPage(),
          ),
        ],
      ),
    ],
  );
});
