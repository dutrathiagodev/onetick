import 'package:flutter/material.dart';

import '../../../../domain/focus/entities/focus_entity.dart';
import '../../widgets/focus_card.dart';
import '../../widgets/rhythm_card.dart';
import '../../widgets/today_status_bar.dart';

/// Success scenario: today's focus is defined and still pending.
class TodayView extends StatelessWidget {
  const TodayView({
    super.key,
    required this.today,
    required this.focus,
    required this.streak,
    required this.isCompleting,
    required this.onComplete,
    required this.onChangeFocus,
  });

  final DateTime today;
  final FocusEntity focus;
  final int streak;
  final bool isCompleting;
  final VoidCallback onComplete;
  final VoidCallback onChangeFocus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        children: [
          TodayStatusBar(today: today, streak: streak),
          const SizedBox(height: 8),
          FocusCard(
            title: focus.title,
            isCompleting: isCompleting,
            onComplete: onComplete,
            onChangeFocus: onChangeFocus,
          ),
          const SizedBox(height: 24),
          const RhythmCard(completed: false),
        ],
      ),
    );
  }
}
