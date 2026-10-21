import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../domain/focus/entities/focus_entity.dart';

/// Card with the 60-character focus text area and live counter.
class FocusInputCard extends StatelessWidget {
  const FocusInputCard({
    super.key,
    required this.controller,
    required this.enabled,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = AppTextStyles.bodyLarge.copyWith(
      color: colors.text,
      height: 24 / 17,
    );
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Qual o seu único foco para hoje?',
            style: AppTextStyles.subtitle.copyWith(color: colors.text),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: colors.surfaceMuted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              key: const Key('define_focus_input'),
              controller: controller,
              enabled: enabled,
              minLines: 2,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              inputFormatters: [
                LengthLimitingTextInputFormatter(FocusEntity.maxTitleLength),
              ],
              onSubmitted: onSubmitted,
              style: style,
              cursorColor: colors.brand,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Escreva algo intencional...',
                hintStyle: style.copyWith(color: colors.textFaint),
                contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      AppIcon(AppAssets.plant, tint: colors.brand),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Simplicidade é a chave',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(
                            color: colors.brand,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (context, value, _) => Row(
                    children: [
                      Text(
                        '${value.text.length}',
                        key: const Key('define_focus_counter'),
                        style: AppTextStyles.labelSemi.copyWith(
                          color: colors.text,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '/ ${FocusEntity.maxTitleLength}',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: colors.textFaint,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
