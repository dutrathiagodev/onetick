import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../app_icon.dart';

/// "Continuar com o Google" pill. Styling differs slightly between the login
/// and sign-up frames, so the look is parameterized.
class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.iconAsset,
    required this.onPressed,
    required this.textStyle,
    required this.background,
    this.height = 52,
    this.borderColor,
    this.gap = 12,
  });

  final String iconAsset;
  final VoidCallback? onPressed;
  final TextStyle textStyle;
  final Color background;
  final double height;
  final Color? borderColor;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Continuar com o Google',
      enabled: onPressed != null,
      child: Opacity(
        opacity: onPressed == null ? 0.5 : 1,
        child: Material(
          color: background,
          shape: StadiumBorder(
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!),
          ),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onPressed,
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcon(iconAsset),
                  SizedBox(width: gap),
                  Flexible(
                    child: Text(
                      'Continuar com o Google',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.copyWith(
                        color: textStyle.color ?? context.colors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
