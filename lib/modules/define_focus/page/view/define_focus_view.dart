import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/bottom_anchored_scroll.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/widgets/dot_pill.dart';
import '../../../../core/widgets/primary_pill_button.dart';
import '../../../../domain/focus/entities/focus_entity.dart';
import '../../widgets/focus_input_card.dart';
import '../../widgets/focus_suggestions.dart';
import '../../widgets/focus_tip_tile.dart';

/// Success scenario of "Definir Foco": input, suggestions, save/cancel.
class DefineFocusView extends StatefulWidget {
  const DefineFocusView({
    super.key,
    required this.initialTitle,
    required this.isSaving,
    required this.message,
    required this.onSave,
    required this.onCancel,
  });

  final String initialTitle;
  final bool isSaving;
  final String? message;
  final ValueChanged<String> onSave;
  final VoidCallback onCancel;

  @override
  State<DefineFocusView> createState() => _DefineFocusViewState();
}

class _DefineFocusViewState extends State<DefineFocusView> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialTitle,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applySuggestion(String text) {
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      top: false,
      child: BottomAnchoredScroll(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        top: [
          DotPill(
            label: 'COMPROMISSO DO DIA',
            background: colors.mint,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            textStyle: AppTextStyles.overline.copyWith(color: colors.onMint),
          ),
          const SizedBox(height: 4),
          Text(
            'Redefinir Prioridade',
            style: AppTextStyles.title.copyWith(color: colors.text),
          ),
          const SizedBox(height: 4),
          Text(
            'Menos ruído, mais presença. Concentre sua energia em um único objetivo.',
            style: AppTextStyles.label.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: 24),
          FocusInputCard(
            controller: _controller,
            enabled: !widget.isSaving,
            onSubmitted: widget.onSave,
          ),
          if (widget.message != null) ...[
            const SizedBox(height: 12),
            Text(
              widget.message!,
              key: const Key('define_focus_error'),
              style: AppTextStyles.label.copyWith(
                color: colors.danger,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ideias intencionais',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                AppIcon(AppAssets.sparkles, tint: colors.textFaint),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FocusSuggestions(onSelected: _applySuggestion),
        ],
        bottom: [
          const SizedBox(height: 24),
          const FocusTipTile(),
          const SizedBox(height: 24),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) {
              final trimmed = value.text.trim();
              final valid =
                  trimmed.isNotEmpty &&
                  trimmed.length <= FocusEntity.maxTitleLength;
              return PrimaryPillButton(
                key: const Key('define_focus_save'),
                label: 'Salvar Foco',
                iconAsset: AppAssets.checkWhite13,
                isLoading: widget.isSaving,
                onPressed: valid ? () => widget.onSave(_controller.text) : null,
                labelStyle: AppTextStyles.subtitle,
              );
            },
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              key: const Key('define_focus_cancel'),
              onPressed: widget.isSaving ? null : widget.onCancel,
              style: TextButton.styleFrom(
                minimumSize: const Size(160, 44),
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Cancelar',
                style: AppTextStyles.body.copyWith(color: colors.textMuted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
