import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// White card holding the Login / Sign-up form.
class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.child, this.emphasized = false});

  final Widget child;

  /// Login frame: 12px corners without border; sign-up: 24px with a hairline.
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsets.all(emphasized ? 24 : 25),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(emphasized ? 12 : 24),
        border: emphasized
            ? null
            : Border.all(color: colors.inverse.withValues(alpha: 0.05)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: AutofillGroup(child: child),
    );
  }
}
