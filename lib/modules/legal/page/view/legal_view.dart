import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/header_bar.dart';
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
        BackTitleBar(
          title: document.title,
          onBack: onBack,
          backKey: const Key('legal_back'),
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
