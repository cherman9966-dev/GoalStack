import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/providers/user_profile_provider.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/time_piker_popup.dart';

class NotificationsSection extends ConsumerStatefulWidget {
  const NotificationsSection({super.key});

  @override
  ConsumerState<NotificationsSection> createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends ConsumerState<NotificationsSection> {
  bool _notificationsEnabled = false;
  String _reminderTime = '20:00';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final currentProfile = ref.read(userProfileProvider);
      setState(() {
        _notificationsEnabled = currentProfile.notificationsEnabled ?? false;
        _reminderTime = currentProfile.reminderTime ?? '20:00';
      });
    });
  }

  Future<void> _selectReminderTime(BuildContext context) async {
    String initialTimeString = _reminderTime;


    if (initialTimeString.isEmpty) {
      final now = TimeOfDay.now();
      initialTimeString =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(
          2, '0')}';
    }

    final String? pickedTime = await showDialog<String>(
      context: context,
      builder: (context) =>
          TimePickerPopup(
            initialTime: initialTimeString,
          ),
    );

    if (pickedTime != null) {
      setState(() {
        _reminderTime = pickedTime;
      });


      await ref.read(userProfileRepositoryProvider).updateReminderTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                value: _notificationsEnabled,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF7B61FF),
                inactiveThumbColor: Colors.white, // Білий кружечок
                inactiveTrackColor: Colors.white.withOpacity(0.20),
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),

              if (_notificationsEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: Colors.white.withOpacity(0.2), height: 1),
                ),

              // РЯДОК ВИБОРУ ЧАСУ (З'являється тільки якщо сповіщення увімкнено)
              if (_notificationsEnabled)
                ListTile(
                  // Додаємо іконку годинника зліва
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
                  // Час + стрілочка вправо
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _reminderTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.8), size: 20),
                    ],
                  ),
                  onTap: () => _selectReminderTime(context),
                ),
            ],
          ),
        ),
      ],
    );
  }
}