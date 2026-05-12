import 'package:isar/isar.dart';
part 'user_profile_entity.g.dart';

@collection
class UserProfileEntity {
  Id id = 0;
  late String name;
  String? email;
  String? imagePath;
  late String authStatus;
  late bool notificationsEnabled;
  late String reminderTime;

  UserProfileEntity({
    this.name = 'Guest',
    this.email,
    this.imagePath,
    this.authStatus = 'guest',
    this.notificationsEnabled = true,
    this.reminderTime = '',
  });

  UserProfileEntity copyWith({
    String? name,
    String? email,
    String? imagePath,
    String? authStatus,
    bool? notificationsEnabled,
    String? reminderTime,
  }) {
    return UserProfileEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      authStatus: authStatus ?? this.authStatus,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
    )..id = this.id;
  }
}
