import 'package:flutter/material.dart';

import '../legal_documents.dart';
import 'view/legal_view.dart';

/// Static document: there is no loading, error or empty scenario.
class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.document});

  final LegalDocument document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LegalView(
        document: document,
        onBack: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}
