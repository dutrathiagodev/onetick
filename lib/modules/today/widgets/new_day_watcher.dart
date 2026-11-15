import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presenter/today/today_cubit.dart';

/// Coming back to the app on a new day (it stayed in the background
/// overnight) reloads Today instead of showing yesterday's focus.
class NewDayWatcher extends StatefulWidget {
  const NewDayWatcher({super.key, required this.child});

  final Widget child;

  @override
  State<NewDayWatcher> createState() => _NewDayWatcherState();
}

class _NewDayWatcherState extends State<NewDayWatcher> {
  late final AppLifecycleListener _lifecycle = AppLifecycleListener(
    onResume: () => context.read<TodayCubit>().refreshIfNewDay(),
  );

  @override
  void initState() {
    super.initState();
    _lifecycle;
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
