import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:goalstack/home/features/presentation/providers/user_profile_provider.dart';
import 'package:intl/intl.dart' show DateFormat;

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Good morning!';
    if (hour >= 12 && hour < 18) return 'Good afternoon!';
    return 'Hi! How did today go?';
  }

  String _getFormattedDate() {
    return DateFormat('EEEE d MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _getFormattedDate(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                ),
              ),
            ],
          ),

          // Кнопка налаштувань справа
          Container(
            margin: const EdgeInsets.only(
              top: 10.0,
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            // Використовуємо ClipRRect або CircleAvatar для відображення фото
            child: InkWell(
              onTap: () {
                context.push('/settings');
              },
              customBorder: const CircleBorder(),
              child: userProfile.imagePath != null
                  ? CircleAvatar(
                radius: 28, // Розмір, що відповідає твоєму IconButton
                backgroundColor: Colors.transparent,
                backgroundImage: FileImage(File(userProfile.imagePath!)),
              )
                  : const Padding(
                padding: EdgeInsets.all(8.0), // Зберігаємо візуальний розмір іконки
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}