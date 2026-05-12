import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goalstack/home/profile/data/user_profile_entity.dart';
import 'package:goalstack/home/profile/repositories/user_profile_repository.dart';
import 'package:isar/isar.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar не був ініціалізований у ProviderScope');
});

// 2. ПРОВАЙДЕР РЕПОЗИТОРІЮ
// Він бере базу з isarProvider і створює об'єкт для роботи з даними
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return UserProfileRepository(isar);
});

// 3. ГОЛОВНИЙ ПРОВАЙДЕР СТАНУ ПРОФІЛЮ
// Це той самий "мозок", який ти будеш викликати на екрані налаштувань
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfileEntity>((ref) {
  final repository = ref.watch(userProfileRepositoryProvider);
  return UserProfileNotifier(repository);
});

// 2. Провайдер стану профілю
class UserProfileNotifier extends StateNotifier<UserProfileEntity> {
  final UserProfileRepository _repository;

  UserProfileNotifier(this._repository) : super(UserProfileEntity()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    state = await _repository.getProfile();
  }

  Future<void> updateName(String newName) async {
    state.name = newName;
    await _repository.saveProfile(state);
    state = await _repository.getProfile();
  }

  Future<void> updateImage(String path) async {
    final updated = UserProfileEntity(
      name: state.name,
      email: state.email,
      imagePath: path,
      authStatus: state.authStatus,
      notificationsEnabled: state.notificationsEnabled,
      reminderTime: state.reminderTime,
    );
    await _repository.saveProfile(updated);
    state = updated;
  }

  Future<void> updateEmail(String email) async {
    state = state.copyWith(email: email);
    await _repository.saveProfile(state);
    _refreshState();
  }

  Future<void> toggleNotifications(bool enabled) async {
    state.notificationsEnabled = enabled;
    await _repository.saveProfile(state);
    state = await _repository.getProfile();
  }

  Future<void> deleteImage() async {
    final updatedProfile = UserProfileEntity(
      name: state.name,
      email: state.email,
      imagePath: null,
      authStatus: state.authStatus,
      notificationsEnabled: state.notificationsEnabled,
      reminderTime: state.reminderTime,
    )..id = state.id;
    state = updatedProfile;
    await _repository.saveProfile(updatedProfile);
  }

  void _refreshState() {
    state = state;
  }

}


