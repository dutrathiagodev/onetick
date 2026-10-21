import 'package:flutter/material.dart';

import '../../../../domain/focus/entities/focus_entity.dart';
import '../../widgets/completed_focus_card.dart';
import '../../widgets/rhythm_card.dart';
import '../../widgets/today_status_bar.dart';

/// "Hoje - Foco Concluído": calm confirmation once the focus is done.
class TodayCompletedView extends StatelessWidget {
  const TodayCompletedView({
    super.key,
    required this.today,
    required this.focus,
    required this.streak,
  });

  final DateTime today;
  final FocusEntity focus;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        children: [
          TodayStatusBar(today: today, streak: streak),
          const SizedBox(height: 8),
          CompletedFocusCard(focus: focus),
          const SizedBox(height: 24),
          const RhythmCard(completed: true),
        ],
      ),
    );
  }
}
