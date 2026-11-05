import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/widgets/onetick_mark.dart';
import '../../legal_documents.dart';

class LegalView extends StatelessWidget {
  const LegalView({super.key, required this.document, required this.onBack});

  final LegalDocument document;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Same frosted header as Definir Foco.
        Container(
          decoration: BoxDecoration(
            color: colors.background.withValues(alpha: 0.85),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 8,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Semantics(
                      button: true,
                      label: 'Voltar',
                      child: InkResponse(
                        key: const Key('legal_back'),
                        onTap: onBack,
                        radius: 24,
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Center(
                            child: AppIcon(
                              AppAssets.backArrow,
                              tint: colors.text,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const OneTickMark(size: 28),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        document.title,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.subtitle.copyWith(
                          color: colors.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Atualizado em ${document.updatedAt}',
                    style: AppTextStyles.label.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final (i, (heading, body))
                            in document.sections.indexed) ...[
                          if (i > 0) const SizedBox(height: 20),
                          Text(
                            heading,
                            style: AppTextStyles.labelSemi.copyWith(
                              color: colors.text,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            body,
                            style: AppTextStyles.body.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ],
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
