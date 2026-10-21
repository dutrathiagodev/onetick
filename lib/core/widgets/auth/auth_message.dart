import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Inline error / info message shown above the submit button.
class AuthMessage extends StatelessWidget {
  const AuthMessage({super.key, required this.message, this.isError = true});

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      liveRegion: true,
      child: Text(
        message,
        key: Key(isError ? 'auth_error_message' : 'auth_info_message'),
        style: AppTextStyles.label.copyWith(
          color: isError ? colors.danger : colors.brand,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
