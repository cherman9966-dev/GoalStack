import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/features/presentation/providers/achievements_provider.dart';
import 'package:goalstack/home/features/presentation/providers/user_profile_provider.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/setting_page_widgets/account_support_section.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/setting_page_widgets/achievements_section.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/setting_page_widgets/data_management_section.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/setting_page_widgets/notifications_section.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingPage> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      imageQuality: 80,
    );

    if (image != null) {
      ref.read(userProfileProvider.notifier).updateImage(image.path);
    }
  }

  Future<void> _showImageOptions() async {
    final userProfile = ref.read(userProfileProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) => Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E3A7A).withOpacity(0.8),
              const Color(0xFF122246).withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black.withOpacity(0.28)),
          // Твоє світіння
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A7A).withOpacity(0.8),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Wrap(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Твої пункти меню
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.black),
                title: const Text(
                  'Choose new photo',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              if (userProfile.imagePath != null)
                ListTile(
                  leading: const Icon(
                    Icons.delete_sweep,
                    color: Colors.redAccent,
                  ),
                  title: const Text(
                    'Remove photo',
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(userProfileProvider.notifier).deleteImage();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.black54),
                title: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final stats = ref.watch(achievementsStatsProvider).value;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/main_backgroundfon.png',
            fit: BoxFit.cover,
          ),
        ),

        // 2. НАША СТОРІНКА НАЛАШТУВАНЬ
        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              _buildProfileHeader(userProfile),
              const SizedBox(height: 30),

              AchievementsSection(
                trophiesCount: stats?.trophiesCount ?? 0,
                firesCount: stats?.totalFires ?? 0,
                completionRate: stats?.completionRate ?? 0.0,
                bestStreakDays: stats?.bestStreak ?? 0,
              ),
              const SizedBox(height: 15),

              const DataManagementSection(),
              const SizedBox(height: 15),

              const NotificationsSection(),
              const SizedBox(height: 15),

              const AccountSupportSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  // ОНОВЛЕНИЙ ВІДЖЕТ ЗАГОЛОВКА ПРОФІЛЮ (По центру, як у дизайні)
  Widget _buildProfileHeader(userProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Аватар з помаранчевою кнопкою
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: _showImageOptions,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 58,
                  backgroundColor: Colors.transparent,
                  backgroundImage: userProfile.imagePath != null
                      ? FileImage(File(userProfile.imagePath!))
                      : null,
                  child: userProfile.imagePath == null
                      ? const Icon(
                          Icons.person_outline,
                          size: 48,
                          color: Colors.black54,
                        )
                      : null,
                ),
              ),
            ),
            // Помаранчева кнопка камери
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _showImageOptions, // Також викликає меню
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B00),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // 2. Ім'я та кнопка редагування
        Padding(
          // Збільшуй значення 'right' (наприклад, 20, 30, 40), щоб сильніше посунути текст вліво
          padding: const EdgeInsets.only(left: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userProfile.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  final TextEditingController nameController =
                      TextEditingController(
                        text: ref.read(userProfileProvider).name,
                      );
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      // 1. Робимо фон системного вікна прозорим
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      // 2. Встановлюємо відступи від країв екрана
                      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        // 3. ТВОЯ КАСТОМНА ДЕКОРАЦІЯ
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF1E3A7A).withOpacity(0.8),
                              const Color(0xFF122246).withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.28),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E3A7A).withOpacity(0.8),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        // 4. КОНТЕНТ ДІАЛОГУ
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // Щоб вікно не розтягнулося на весь екран
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Change Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: nameController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "Enter your nickname",
                                hintStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                                // Стилізуємо лінію під текстом, щоб пасувала до дизайну
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            // КНОПКИ ДІЙ
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                OutlinedButton(
                                  onPressed: () {
                                    ref
                                        .read(userProfileProvider.notifier)
                                        .updateName(nameController.text);
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
