import 'package:equatable/equatable.dart';

/// The single commitment a user picks for one calendar day.
class FocusEntity extends Equatable {
  const FocusEntity({
    required this.dateKey,
    required this.title,
    this.completed = false,
    this.completedAt,
  });

  /// `yyyy-MM-dd` of the day this focus belongs to.
  final String dateKey;
  final String title;
  final bool completed;
  final DateTime? completedAt;

  static const int maxTitleLength = 60;

  FocusEntity copyWith({
    String? title,
    bool? completed,
    DateTime? completedAt,
  }) {
    return FocusEntity(
      dateKey: dateKey,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [dateKey, title, completed, completedAt];
}
