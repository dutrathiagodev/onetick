import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_icon.dart';

/// "Quero foco essencial em 1 tarefa por vez." micro commitment check.
class CommitmentCheck extends StatelessWidget {
  const CommitmentCheck({
    super.key,
    required this.checked,
    required this.onChanged,
  });

  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      checked: checked,
      inMutuallyExclusiveGroup: false,
      label: 'Quero foco essencial em 1 tarefa por vez.',
      child: InkWell(
        key: const Key('register_commitment'),
        borderRadius: BorderRadius.circular(8),
        onTap: () => onChanged(!checked),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: checked ? colors.brand : Colors.transparent,
                  shape: BoxShape.circle,
                  border: checked
                      ? null
                      : Border.all(color: colors.outline, width: 1.5),
                ),
                alignment: Alignment.center,
                child: checked
                    ? AppIcon(
                        AppAssets.checkWhiteCheckbox,
                        tint: colors.onBrand,
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Quero foco essencial em 1 tarefa por vez.',
                  style: AppTextStyles.label.copyWith(
                    fontSize: 12.5,
                    height: 15.63 / 12.5,
                    color: colors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
