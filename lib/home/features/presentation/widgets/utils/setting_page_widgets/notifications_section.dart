import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/providers/notification_provider.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/time_piker_popup.dart';

class NotificationsSection extends ConsumerWidget {
  const NotificationsSection({super.key});

  Future<void> _selectReminderTime(BuildContext context, WidgetRef ref, TimeOfDay initialTime) async {
    final String initialTimeString =
        '${initialTime.hour.toString().padLeft(2, '0')}:${initialTime.minute.toString().padLeft(2, '0')}';

    final String? pickedTime = await showDialog<String>(
      context: context,
      builder: (context) => TimePickerPopup(
        initialTime: initialTimeString,
      ),
    );

    if (pickedTime != null) {
      final parts = pickedTime.split(':');
      final newTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
      await ref.read(notificationSettingsProvider.notifier).updateTime(newTime);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationSettingsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E3A7A).withOpacity(0.8),
                const Color(0xFF122246).withOpacity(0.20),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              // ПЕРЕМИКАЧ СПОВІЩЕНЬ
              SwitchListTile(
                title: const Text(
                  'Daily Reminder',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Stay on track with reminders about your goal progress',
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                ),
                value: notificationState.isEnabled,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF7B61FF),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.white.withOpacity(0.20),
                onChanged: (bool value) {
                  ref.read(notificationSettingsProvider.notifier).toggleNotifications(value);
                },
              ),

              if (notificationState.isEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: Colors.white.withOpacity(0.2), height: 1),
                ),

              // РЯДОК ВИБОРУ ЧАСУ
              if (notificationState.isEnabled)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.access_time, color: Colors.white, size: 22),
                  ),
                  title: const Text(
                    'Reminder time',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${notificationState.selectedTime.hour.toString().padLeft(2, '0')}:${notificationState.selectedTime.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.8), size: 20),
                    ],
                  ),
                  onTap: () => _selectReminderTime(context, ref, notificationState.selectedTime),
                ),
            ],
          ),
        ),
      ],
    );
  }
}