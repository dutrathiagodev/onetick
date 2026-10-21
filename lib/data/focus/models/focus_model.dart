import '../../../domain/focus/entities/focus_entity.dart';

class FocusModel {
  const FocusModel({
    required this.dateKey,
    required this.title,
    required this.completed,
    this.completedAt,
  });

  final String dateKey;
  final String title;
  final bool completed;
  final DateTime? completedAt;

  factory FocusModel.fromMap(Map<String, dynamic> map) {
    return FocusModel(
      dateKey: map['dateKey'] as String,
      title: (map['title'] as String?) ?? '',
      completed: (map['completed'] as bool?) ?? false,
      completedAt: map['completedAt'] as DateTime?,
    );
  }

  factory FocusModel.fromEntity(FocusEntity entity) {
    return FocusModel(
      dateKey: entity.dateKey,
      title: entity.title,
      completed: entity.completed,
      completedAt: entity.completedAt,
    );
  }

  Map<String, dynamic> toMap() => {
    'dateKey': dateKey,
    'title': title,
    'completed': completed,
    'completedAt': completedAt,
  };

  FocusEntity toEntity() => FocusEntity(
    dateKey: dateKey,
    title: title,
    completed: completed,
    completedAt: completedAt,
  );
}
