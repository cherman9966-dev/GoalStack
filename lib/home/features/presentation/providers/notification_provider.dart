import 'package:flutter/material.dart';
import 'package:goalstack/core/services/notification_service.dart';
import 'package:goalstack/home/features/presentation/providers/user_profile_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

/// Стан налаштувань сповіщень
class NotificationState {
  final bool isEnabled;
  final TimeOfDay selectedTime;

  NotificationState({
    required this.isEnabled,
    required this.selectedTime,
  });

  NotificationState copyWith({
    bool? isEnabled,
    TimeOfDay? selectedTime,
  }) {
    return NotificationState(
      isEnabled: isEnabled ?? this.isEnabled,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}

@riverpod
class NotificationSettings extends _$NotificationSettings {
  @override
  NotificationState build() {
    // Отримуємо початкові дані з профілю користувача
    final userProfile = ref.watch(userProfileProvider);
    
    // Парсимо час з рядка (наприклад, "20:00")
    TimeOfDay initialTime = const TimeOfDay(hour: 20, minute: 0);
    if (userProfile.reminderTime.isNotEmpty) {
      final parts = userProfile.reminderTime.split(':');
      if (parts.length == 2) {
        initialTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    }

    return NotificationState(
      isEnabled: userProfile.notificationsEnabled,
      selectedTime: initialTime,
    );
  }

  /// Увімкнути/Вимкнути сповіщення
  Future<void> toggleNotifications(bool value) async {
    if (value) {
      // Запитуємо дозволи (особливо важливо для iOS та Android 13+)
      final hasPermission = await NotificationService.requestPermissions();
      // if (!hasPermission) {
      //   // Якщо дозволу немає, залишаємо вимкненим
      //   state = state.copyWith(isEnabled: false);
      //   return;
      // }
    }

    state = state.copyWith(isEnabled: value);
    
    // Зберігаємо в профіль через провайдер стану
    await ref.read(userProfileProvider.notifier).toggleNotifications(value);
    
    // Оновлюємо розклад
    await _updateSchedule();
  }

  /// Оновити час нагадування
  Future<void> updateTime(TimeOfDay newTime) async {
    state = state.copyWith(selectedTime: newTime);
    
    // Зберігаємо в профіль через провайдер стану
    final timeString = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
    await ref.read(userProfileProvider.notifier).updateReminderTime(timeString);
    
    // Оновлюємо розклад
    await _updateSchedule();
  }

  /// Внутрішній метод для перепланування сповіщень
  Future<void> _updateSchedule() async {
    // Спочатку скасовуємо все старе
    await NotificationService.cancelAll();

    // Якщо сповіщення увімкнені, плануємо нове
    if (state.isEnabled) {
      await NotificationService.scheduleDailyReminder(
        id: 0,
        title: 'Час для твоїх цілей! 🔥',
        body: 'Не забудь відмітити свій прогрес у GoalStack сьогодні.',
        hour: state.selectedTime.hour,
        minute: state.selectedTime.minute,
      );
    }
  }
}
