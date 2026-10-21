import 'package:flutter/material.dart';

import '../../../../core/widgets/state_views.dart';

class SettingsErrorView extends StatelessWidget {
  const SettingsErrorView({
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
