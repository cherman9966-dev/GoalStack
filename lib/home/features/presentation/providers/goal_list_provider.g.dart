// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasActiveGoalsHash() => r'e29d59dbb606aa2f22062ea16b53c1c000c901c5';

/// See also [hasActiveGoals].
@ProviderFor(hasActiveGoals)
final hasActiveGoalsProvider = AutoDisposeProvider<bool>.internal(
  hasActiveGoals,
  name: r'hasActiveGoalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasActiveGoalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HasActiveGoalsRef = AutoDisposeProviderRef<bool>;
String _$goalListHash() => r'd8e6409bf50e5c00a44a35bb9bdc9fe8d01d8e62';

/// See also [GoalList].
@ProviderFor(GoalList)
final goalListProvider = NotifierProvider<GoalList, List<GoalEntity>>.internal(
  GoalList.new,
  name: r'goalListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goalListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GoalList = Notifier<List<GoalEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
