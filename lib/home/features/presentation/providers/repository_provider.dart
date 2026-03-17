import 'package:goalstack/home/features/domain/repository/goal_repoositiry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_provider.g.dart';

// Це "порожня оболонка". Ми наповнимо її справжнім репозиторієм у main.dart
@Riverpod(keepAlive: true)
GoalRepository goalRepository(GoalRepositoryRef ref) {
  throw UnimplementedError('Цей провайдер має бути перевизначений у main.dart');
}
