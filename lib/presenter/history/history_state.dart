import 'package:equatable/equatable.dart';

import '../../domain/history/entities/history_overview.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryEmpty extends HistoryState {
  const HistoryEmpty();
}

class HistoryError extends HistoryState {
  const HistoryError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class HistoryLoaded extends HistoryState {
  const HistoryLoaded({
    required this.overview,
    required this.today,
    required this.canGoNext,
    this.isRefreshing = false,
  });

  final HistoryOverview overview;
  final DateTime today;
  final bool canGoNext;
  final bool isRefreshing;

  @override
  List<Object?> get props => [overview, today, canGoNext, isRefreshing];
}
