import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

/// Quick "Ideias intencionais" chips that fill the input.
class FocusSuggestions extends StatelessWidget {
  const FocusSuggestions({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  static const _ideas = [
    ('Ler 10 páginas', AppAssets.ideaBook),
    ('Caminhar 20 min', AppAssets.ideaWalk),
    ('Meditar 5 min', AppAssets.ideaMeditate),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (label, icon) in _ideas)
          Material(
            color: colors.surfaceMuted,
            shape: const StadiumBorder(),
            child: InkWell(
              key: Key('suggestion_$label'),
              customBorder: const StadiumBorder(),
              onTap: () => onSelected(label),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: colors.surfaceStronger,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: AppIcon(icon, tint: colors.text),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: AppTextStyles.label.copyWith(
                        color: colors.text,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
