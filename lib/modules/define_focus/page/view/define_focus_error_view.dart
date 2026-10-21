import 'package:flutter/material.dart';

import '../../../../core/widgets/state_views.dart';

class DefineFocusErrorView extends StatelessWidget {
  const DefineFocusErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) =>
      ErrorStateView(message: message, onRetry: onRetry);
}
