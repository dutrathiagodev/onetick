import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/app_bottom_nav.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../presenter/shell/shell_cubit.dart';
import '../../history/page/history_page.dart';
import '../../settings/page/settings_page.dart';
import '../../today/page/today_page.dart';
import '../widgets/account_sheet.dart';

/// Authenticated shell: top bar + current tab + bottom navigation.
/// Only the selected tab is built, so each tab reloads fresh data on entry.
class ShellPage extends StatelessWidget {
  const ShellPage({super.key});

  static const _sections = {
    HomeTab.today: 'Hoje',
    HomeTab.history: 'Histórico',
    HomeTab.settings: 'Configurações',
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShellCubit>(
      create: (_) => ShellCubit(),
      child: BlocBuilder<ShellCubit, HomeTab>(
        builder: (context, tab) {
          return Scaffold(
            body: Column(
              children: [
                AppTopBar(
                  section: _sections[tab]!,
                  onAvatarPressed: () => showAccountSheet(context),
                ),
                Expanded(
                  child: switch (tab) {
                    HomeTab.today => const TodayPage(
                      key: ValueKey('tab_today'),
                    ),
                    HomeTab.history => const HistoryPage(
                      key: ValueKey('tab_history'),
                    ),
                    HomeTab.settings => const SettingsPage(
                      key: ValueKey('tab_settings'),
                    ),
                  },
                ),
              ],
            ),
            bottomNavigationBar: AppBottomNav(
              items: kHomeNavItems,
              currentIndex: tab.index,
              onSelected: (i) =>
                  context.read<ShellCubit>().select(HomeTab.values[i]),
            ),
          );
        },
      ),
    );
  }
}
