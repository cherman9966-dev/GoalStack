// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGoalEntityCollection on Isar {
  IsarCollection<GoalEntity> get goalEntitys => this.collection();
}

const GoalEntitySchema = CollectionSchema(
  name: r'GoalEntity',
  id: -5725872661757418951,
  properties: {
    r'calendarSelectedDays': PropertySchema(
      id: 0,
      name: r'calendarSelectedDays',
      type: IsarType.boolList,
    ),
    r'colorValue': PropertySchema(
      id: 1,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'completedDates': PropertySchema(
      id: 2,
      name: r'completedDates',
      type: IsarType.dateTimeList,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'customTargetDays': PropertySchema(
      id: 4,
      name: r'customTargetDays',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'goalType': PropertySchema(
      id: 6,
      name: r'goalType',
      type: IsarType.string,
    ),
    r'iconCodePoint': PropertySchema(
      id: 7,
      name: r'iconCodePoint',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 8,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isDeleted': PropertySchema(
      id: 9,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'scheduledTime': PropertySchema(
      id: 10,
      name: r'scheduledTime',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 11,
      name: r'status',
      type: IsarType.string,
    ),
    r'streak': PropertySchema(
      id: 12,
      name: r'streak',
      type: IsarType.long,
    ),
    r'streakEarnedDates': PropertySchema(
      id: 13,
      name: r'streakEarnedDates',
      type: IsarType.dateTimeList,
    ),
    r'title': PropertySchema(
      id: 14,
      name: r'title',
      type: IsarType.string,
    ),
    r'totalFiresInsideGoal': PropertySchema(
      id: 15,
      name: r'totalFiresInsideGoal',
      type: IsarType.long,
    ),
    r'weekDaysStatus': PropertySchema(
      id: 16,
      name: r'weekDaysStatus',
      type: IsarType.boolList,
    )
  },
  estimateSize: _goalEntityEstimateSize,
  serialize: _goalEntitySerialize,
  deserialize: _goalEntityDeserialize,
  deserializeProp: _goalEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _goalEntityGetId,
  getLinks: _goalEntityGetLinks,
  attach: _goalEntityAttach,
  version: '3.1.0+1',
);

int _goalEntityEstimateSize(
  GoalEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.calendarSelectedDays.length;
  bytesCount += 3 + object.completedDates.length * 8;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.goalType.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.streakEarnedDates.length * 8;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.weekDaysStatus.length;
  return bytesCount;
}

void _goalEntitySerialize(
  GoalEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBoolList(offsets[0], object.calendarSelectedDays);
  writer.writeLong(offsets[1], object.colorValue);
  writer.writeDateTimeList(offsets[2], object.completedDates);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.customTargetDays);
  writer.writeString(offsets[5], object.description);
  writer.writeString(offsets[6], object.goalType);
  writer.writeLong(offsets[7], object.iconCodePoint);
  writer.writeBool(offsets[8], object.isCompleted);
  writer.writeBool(offsets[9], object.isDeleted);
  writer.writeDateTime(offsets[10], object.scheduledTime);
  writer.writeString(offsets[11], object.status);
  writer.writeLong(offsets[12], object.streak);
  writer.writeDateTimeList(offsets[13], object.streakEarnedDates);
  writer.writeString(offsets[14], object.title);
  writer.writeLong(offsets[15], object.totalFiresInsideGoal);
  writer.writeBoolList(offsets[16], object.weekDaysStatus);
}

GoalEntity _goalEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoalEntity();
  object.calendarSelectedDays = reader.readBoolList(offsets[0]) ?? [];
  object.colorValue = reader.readLongOrNull(offsets[1]);
  object.completedDates = reader.readDateTimeList(offsets[2]) ?? [];
  object.createdAt = reader.readDateTime(offsets[3]);
  object.customTargetDays = reader.readLong(offsets[4]);
  object.description = reader.readStringOrNull(offsets[5]);
  object.goalType = reader.readString(offsets[6]);
  object.iconCodePoint = reader.readLongOrNull(offsets[7]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[8]);
  object.isDeleted = reader.readBool(offsets[9]);
  object.scheduledTime = reader.readDateTimeOrNull(offsets[10]);
  object.status = reader.readString(offsets[11]);
  object.streak = reader.readLong(offsets[12]);
  object.streakEarnedDates = reader.readDateTimeList(offsets[13]) ?? [];
  object.title = reader.readString(offsets[14]);
  object.totalFiresInsideGoal = reader.readLong(offsets[15]);
  object.weekDaysStatus = reader.readBoolList(offsets[16]) ?? [];
  return object;
}

P _goalEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolList(offset) ?? []) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeList(offset) ?? []) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readDateTimeList(offset) ?? []) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readBoolList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _goalEntityGetId(GoalEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _goalEntityGetLinks(GoalEntity object) {
  return [];
}

void _goalEntityAttach(IsarCollection<dynamic> col, Id id, GoalEntity object) {
  object.id = id;
}

extension GoalEntityQueryWhereSort
    on QueryBuilder<GoalEntity, GoalEntity, QWhere> {
  QueryBuilder<GoalEntity, GoalEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GoalEntityQueryWhere
    on QueryBuilder<GoalEntity, GoalEntity, QWhereClause> {
  QueryBuilder<GoalEntity, GoalEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GoalEntityQueryFilter
    on QueryBuilder<GoalEntity, GoalEntity, QFilterCondition> {
  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      calendarSelectedDaysElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calendarSelectedDays',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      calendarSelectedDaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'calendarSelectedDays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      calendarSelectedDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'calendarSelectedDays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      calendarSelectedDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'calendarSelectedDays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      calendarSelectedDaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'calendarSelectedDays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      calendarSelectedDaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'calendarSelectedDays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      calendarSelectedDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'calendarSelectedDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      colorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'colorValue',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      colorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'colorValue',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> colorValueEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      colorValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      colorValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> colorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesElementEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedDates',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesElementGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedDates',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesElementLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedDates',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesElementBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedDates',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedDates',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedDates',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedDates',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedDates',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedDates',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      completedDatesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedDates',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      customTargetDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customTargetDays',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      customTargetDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customTargetDays',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      customTargetDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customTargetDays',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      customTargetDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customTargetDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> goalTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      goalTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> goalTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> goalTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      goalTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> goalTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> goalTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> goalTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goalType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      goalTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalType',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      goalTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goalType',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      iconCodePointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconCodePoint',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      iconCodePointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconCodePoint',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      iconCodePointEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      iconCodePointGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      iconCodePointLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      iconCodePointBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconCodePoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> isDeletedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      scheduledTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduledTime',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      scheduledTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduledTime',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      scheduledTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      scheduledTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      scheduledTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      scheduledTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> streakEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streak',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> streakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streak',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> streakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streak',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> streakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesElementEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streakEarnedDates',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesElementGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streakEarnedDates',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesElementLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streakEarnedDates',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesElementBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streakEarnedDates',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'streakEarnedDates',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'streakEarnedDates',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'streakEarnedDates',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'streakEarnedDates',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'streakEarnedDates',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      streakEarnedDatesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'streakEarnedDates',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      totalFiresInsideGoalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFiresInsideGoal',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      totalFiresInsideGoalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFiresInsideGoal',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      totalFiresInsideGoalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFiresInsideGoal',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      totalFiresInsideGoalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFiresInsideGoal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      weekDaysStatusElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekDaysStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      weekDaysStatusLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekDaysStatus',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      weekDaysStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekDaysStatus',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      weekDaysStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekDaysStatus',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      weekDaysStatusLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekDaysStatus',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      weekDaysStatusLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekDaysStatus',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterFilterCondition>
      weekDaysStatusLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weekDaysStatus',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension GoalEntityQueryObject
    on QueryBuilder<GoalEntity, GoalEntity, QFilterCondition> {}

extension GoalEntityQueryLinks
    on QueryBuilder<GoalEntity, GoalEntity, QFilterCondition> {}

extension GoalEntityQuerySortBy
    on QueryBuilder<GoalEntity, GoalEntity, QSortBy> {
  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByCustomTargetDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTargetDays', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy>
      sortByCustomTargetDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTargetDays', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByGoalType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByGoalTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy>
      sortByTotalFiresInsideGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiresInsideGoal', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy>
      sortByTotalFiresInsideGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiresInsideGoal', Sort.desc);
    });
  }
}

extension GoalEntityQuerySortThenBy
    on QueryBuilder<GoalEntity, GoalEntity, QSortThenBy> {
  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByCustomTargetDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTargetDays', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy>
      thenByCustomTargetDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTargetDays', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByGoalType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByGoalTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy>
      thenByTotalFiresInsideGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiresInsideGoal', Sort.asc);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QAfterSortBy>
      thenByTotalFiresInsideGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiresInsideGoal', Sort.desc);
    });
  }
}

extension GoalEntityQueryWhereDistinct
    on QueryBuilder<GoalEntity, GoalEntity, QDistinct> {
  QueryBuilder<GoalEntity, GoalEntity, QDistinct>
      distinctByCalendarSelectedDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calendarSelectedDays');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByCompletedDates() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedDates');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByCustomTargetDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customTargetDays');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByGoalType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconCodePoint');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledTime');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streak');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct>
      distinctByStreakEarnedDates() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streakEarnedDates');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct>
      distinctByTotalFiresInsideGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFiresInsideGoal');
    });
  }

  QueryBuilder<GoalEntity, GoalEntity, QDistinct> distinctByWeekDaysStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekDaysStatus');
    });
  }
}

extension GoalEntityQueryProperty
    on QueryBuilder<GoalEntity, GoalEntity, QQueryProperty> {
  QueryBuilder<GoalEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GoalEntity, List<bool>, QQueryOperations>
      calendarSelectedDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calendarSelectedDays');
    });
  }

  QueryBuilder<GoalEntity, int?, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<GoalEntity, List<DateTime>, QQueryOperations>
      completedDatesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedDates');
    });
  }

  QueryBuilder<GoalEntity, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<GoalEntity, int, QQueryOperations> customTargetDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customTargetDays');
    });
  }

  QueryBuilder<GoalEntity, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<GoalEntity, String, QQueryOperations> goalTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalType');
    });
  }

  QueryBuilder<GoalEntity, int?, QQueryOperations> iconCodePointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconCodePoint');
    });
  }

  QueryBuilder<GoalEntity, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<GoalEntity, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<GoalEntity, DateTime?, QQueryOperations>
      scheduledTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledTime');
    });
  }

  QueryBuilder<GoalEntity, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<GoalEntity, int, QQueryOperations> streakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streak');
    });
  }

  QueryBuilder<GoalEntity, List<DateTime>, QQueryOperations>
      streakEarnedDatesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streakEarnedDates');
    });
  }

  QueryBuilder<GoalEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<GoalEntity, int, QQueryOperations>
      totalFiresInsideGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFiresInsideGoal');
    });
  }

  QueryBuilder<GoalEntity, List<bool>, QQueryOperations>
      weekDaysStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekDaysStatus');
    });
  }
}
