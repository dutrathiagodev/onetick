import 'package:flutter/material.dart';

import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/header_bar.dart';

/// Header of the define-focus screen: back, logo, "Editar Foco", avatar.
class DefineFocusHeader extends StatelessWidget implements PreferredSizeWidget {
  const DefineFocusHeader({
    super.key,
    required this.onBack,
    required this.onAvatar,
    this.photoUrl,
  });

  final VoidCallback onBack;
  final VoidCallback onAvatar;
  final String? photoUrl;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return BackTitleBar(
      title: 'Editar Foco',
      onBack: onBack,
      backKey: const Key('define_focus_back'),
      trailing: UserAvatarButton(onPressed: onAvatar, photoUrl: photoUrl),
    );
  }
}
