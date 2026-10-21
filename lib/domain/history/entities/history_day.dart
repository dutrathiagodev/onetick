import 'package:equatable/equatable.dart';

import '../../focus/entities/focus_entity.dart';

class HistoryDay extends Equatable {
  const HistoryDay({required this.date, this.entry});

  final DateTime date;
  final FocusEntity? entry;

  @override
  List<Object?> get props => [date, entry];
}
