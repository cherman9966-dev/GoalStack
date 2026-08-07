import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  /// Повертає дату без часу (рік, місяць, день 00:00:00)
  /// Це критично для пошуку та порівняння в календарі Isar
  DateTime get dateOnly => DateTime(year, month, day);

  /// Корисна функція, якщо захочеш вивести дату текстом
  String get toFormattedString => DateFormat('dd.MM.yyyy').format(this);

  /// Перевіряє, чи є ця дата сьогоднішньою
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}