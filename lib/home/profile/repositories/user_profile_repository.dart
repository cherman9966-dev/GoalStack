import 'package:isar/isar.dart';
import 'package:goalstack/home/profile/data/user_profile_entity.dart';

class UserProfileRepository {
  final Isar isar;

  UserProfileRepository(this.isar);

  Future<UserProfileEntity> getProfile() async {
    final profile = await isar.userProfileEntitys.get(0);
    return profile ?? UserProfileEntity();
  }

  Future<void> saveProfile(UserProfileEntity profile) async {
    await isar.writeTxn(() async {
      await isar.userProfileEntitys.put(profile);
    });
  }

  Future<void> updateReminderTime(String newTime) async {
    await isar.writeTxn(() async {
      final profile = await isar.userProfileEntitys.get(0) ?? UserProfileEntity();
      profile.reminderTime = newTime;
      await isar.userProfileEntitys.put(profile);
    });
  }
}