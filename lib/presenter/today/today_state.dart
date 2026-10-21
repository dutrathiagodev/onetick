import 'package:equatable/equatable.dart';

import '../../domain/focus/entities/focus_entity.dart';

sealed class TodayState extends Equatable {
  const TodayState();

  @override
  List<Object?> get props => [];
}

class TodayLoading extends TodayState {
  const TodayLoading();
}

/// No focus defined for today yet.
class TodayEmpty extends TodayState {
  const TodayEmpty({required this.streak});

  final int streak;

  @override
  List<Object?> get props => [streak];
}

class TodayError extends TodayState {
  const TodayError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Focus defined, not completed yet ("Hoje - OneTick").
class TodayPending extends TodayState {
  const TodayPending({
    required this.focus,
    required this.streak,
    this.isCompleting = false,
    this.notice,
  });

  final FocusEntity focus;
  final int streak;
  final bool isCompleting;
  final String? notice;

  @override
  List<Object?> get props => [focus, streak, isCompleting, notice];
}

/// Focus completed ("Hoje - Foco Concluído - OneTick").
class TodayCompleted extends TodayState {
  const TodayCompleted({
    required this.focus,
    required this.streak,
    this.isUndoing = false,
    this.notice,
  });

  final FocusEntity focus;
  final int streak;
  final bool isUndoing;
  final String? notice;

  @override
  List<Object?> get props => [focus, streak, isUndoing, notice];
}
