import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
part 'goal_entity.g.dart';

@collection
class GoalEntity {
  Id id = Isar.autoIncrement;

  late String title;
  String? description;
  DateTime? scheduledTime;
  int streak = 0;
  bool isCompleted = false;
  late DateTime createdAt;
  late String status;

  List<DateTime> completedDates = [];

  List<bool> weekDaysStatus = [false, false, false, false, false, false, false];

  int? iconCodePoint;
  int? colorValue;

  @ignore
  IconData? get icon => iconCodePoint != null
      ? IconData(iconCodePoint!, fontFamily: 'MaterialIcons')
      : null;

  @ignore
  set icon(IconData? value) => iconCodePoint = value?.codePoint;

  @ignore
  Color? get color => colorValue != null ? Color(colorValue!) : null;

  @ignore
  set color(Color? value) => colorValue = value?.value;

  String goalType = 'all_days';

  int customTargetDays = 3;

  List<bool> calendarSelectedDays = [];

  GoalEntity();
}