import 'package:isar/isar.dart';
import 'package:flutter/material.dart';
import 'package:goalstack/home/features/domain/entities/goal_entity.dart';

part 'goal_model_isar.g.dart';

@collection
class GoalModel {
  Id id = Isar.autoIncrement;

  late String title;
  late int streak;
  late int iconCodePoint;
  late int colorValue;
  late DateTime createdAt;

  GoalEntity toEntity() {
    return GoalEntity(
      id: id.toString(),
      title: title,
      streak: streak,
      icon: IconData(iconCodePoint, fontFamily: 'MaterialIcons'),
      color: Color(colorValue),
      createdAt: createdAt,
    );
  }
}
