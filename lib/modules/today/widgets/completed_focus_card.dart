import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../domain/focus/entities/focus_entity.dart';

/// Main card of "Hoje (Concluído)" from the Stitch design: celebration badge,
/// done check, struck-through task, a closing note and the two actions.
class CompletedFocusCard extends StatelessWidget {
  const CompletedFocusCard({
    super.key,
    required this.focus,
    required this.isUndoing,
    required this.onSeeHistory,
    required this.onUndo,
  });

  final FocusEntity focus;
  final bool isUndoing;
  final VoidCallback onSeeHistory;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final at = focus.completedAt;
    final time = at == null ? null : DateFormat('HH:mm').format(at);
    return AppCard(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: ShapeDecoration(
              color: colors.mint,
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.task_alt_rounded, size: 13, color: colors.onMint),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'FOCO CONCLUÍDO',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption.copyWith(
                      color: colors.onMint,
                      letterSpacing: 0.55,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.brand, width: 2),
            ),
            alignment: Alignment.center,
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: colors.brand,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.done_all_rounded,
                size: 34,
                color: colors.onBrand,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Foco de hoje concluído!',
            key: const Key('today_completed_heading'),
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle.copyWith(
              color: colors.text,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceMuted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppIcon(AppAssets.checkCircle, tint: colors.brand),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        focus.title,
                        key: const Key('today_completed_title'),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colors.textMuted,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: colors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Icon(
                        Icons.schedule_rounded,
                        size: 13,
                        color: colors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        time == null
                            ? 'Presença e calma pelo resto do dia'
                            : 'Feito às $time • Presença e calma pelo resto do dia',
                        key: const Key('today_completed_time'),
                        style: AppTextStyles.caption.copyWith(
                          color: colors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sem cobranças adicionais por hoje. O OneTick só exige um passo por dia. Aproveite seu tempo livre e descanse.',
            textAlign: TextAlign.center,
            style: AppTextStyles.label.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: 20),
          Material(
            color: colors.surfaceContainer,
            shape: const StadiumBorder(),
            child: InkWell(
              key: const Key('today_see_history'),
              customBorder: const StadiumBorder(),
              onTap: onSeeHistory,
              child: SizedBox(
                height: 44,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ver no Histórico',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: colors.text,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppIcon(AppAssets.arrowRight, tint: colors.text),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            key: const Key('today_undo_completion'),
            onPressed: isUndoing ? null : onUndo,
            style: TextButton.styleFrom(
              minimumSize: const Size(160, 44),
              shape: const StadiumBorder(),
            ),
            child: isUndoing
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.textMuted,
                    ),
                  )
                : Text(
                    'Desfazer conclusão',
                    style: AppTextStyles.caption.copyWith(
                      color: colors.textMuted,
                      decoration: TextDecoration.underline,
                      decorationColor: colors.textMuted,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
