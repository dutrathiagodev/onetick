import 'package:intl/intl.dart';

/// Date helpers shared by domain, data and presentation layers.
abstract final class DateUtilsX {
  static final DateFormat _keyFormat = DateFormat('yyyy-MM-dd');

  /// Storage key for a calendar day (`2024-10-30`), ignoring time of day.
  static String keyOf(DateTime date) => _keyFormat.format(date);

  static DateTime parseKey(String key) => _keyFormat.parse(key);

  static DateTime dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static int daysInMonth(int year, int month) =>
      DateTime(year, month + 1, 0).day;

  static const List<String> _weekdays = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo',
  ];

  static const List<String> _monthsShort = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];

  static const List<String> _monthsLong = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  static String monthName(int month) => _monthsLong[month - 1];

  static String monthShort(int month) => _monthsShort[month - 1];

  static String monthTitle(DateTime date) =>
      '${_monthsLong[date.month - 1]} ${date.year}';

  /// `HOJE • 24 OUT` style label (upper-cased by the caller when needed).
  static String todayBadge(DateTime date) =>
      'Hoje • ${date.day} ${monthShort(date.month)}';

  /// `Hoje, 30 de Out`, `Ontem, 29 de Out`, `Segunda, 28 de Out`.
  static String relativeDayLabel(DateTime date, DateTime today) {
    final diff = dateOnly(today).difference(dateOnly(date)).inDays;
    final prefix = switch (diff) {
      0 => 'Hoje',
      1 => 'Ontem',
      _ => _weekdays[date.weekday - 1],
    };
    return '$prefix, ${date.day} de ${monthShort(date.month)}';
  }
}
