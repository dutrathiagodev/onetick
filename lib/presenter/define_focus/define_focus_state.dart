import 'package:equatable/equatable.dart';

sealed class DefineFocusState extends Equatable {
  const DefineFocusState();

  @override
  List<Object?> get props => [];
}

class DefineFocusLoading extends DefineFocusState {
  const DefineFocusLoading();
}

class DefineFocusError extends DefineFocusState {
  const DefineFocusError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class DefineFocusReady extends DefineFocusState {
  const DefineFocusReady({
    required this.initialTitle,
    this.isSaving = false,
    this.message,
  });

  final String initialTitle;
  final bool isSaving;
  final String? message;

  @override
  List<Object?> get props => [initialTitle, isSaving, message];
}

class DefineFocusSaved extends DefineFocusState {
  const DefineFocusSaved();
}
