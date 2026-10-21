import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../app_icon.dart';

/// Filled rounded input with a leading Figma icon and optional trailing widget.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.iconAsset,
    this.radius = 12,
    this.verticalPadding = 16,
    this.textStyle,
    this.hintColor,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.trailing,
    this.autofillHints,
    this.enabled = true,
    this.iconTint,
  });

  final TextEditingController controller;
  final String hint;
  final String iconAsset;
  final double radius;
  final double verticalPadding;
  final TextStyle? textStyle;
  final Color? hintColor;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final Widget? trailing;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final Color? iconTint;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = (textStyle ?? AppTextStyles.body).copyWith(
      color: colors.text,
    );
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceMuted,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: [
          AppIcon(iconAsset, tint: iconTint),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              autofillHints: autofillHints,
              autocorrect: false,
              enableSuggestions: !obscureText,
              style: style,
              cursorColor: colors.brand,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: style.copyWith(
                  color: hintColor ?? colors.textFaint.withValues(alpha: 0.7),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: verticalPadding,
                ),
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Eye button used to reveal/hide a password field.
class PasswordVisibilityButton extends StatelessWidget {
  const PasswordVisibilityButton({
    super.key,
    required this.visible,
    required this.onPressed,
    required this.assetWhenHidden,
    this.tint,
  });

  final bool visible;
  final VoidCallback onPressed;
  final String assetWhenHidden;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: visible ? 'Ocultar senha' : 'Mostrar senha',
      child: InkResponse(
        onTap: onPressed,
        radius: 22,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: visible
                ? Icon(
                    Icons.visibility_off_outlined,
                    size: 18,
                    color: tint ?? colors.textMuted,
                  )
                : AppIcon(assetWhenHidden, tint: tint),
          ),
        ),
      ),
    );
  }
}
