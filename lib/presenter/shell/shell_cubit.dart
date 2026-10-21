import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeTab { today, history, settings }

/// Selected bottom navigation tab.
class ShellCubit extends Cubit<HomeTab> {
  ShellCubit() : super(HomeTab.today);

  void select(HomeTab tab) => emit(tab);
}
