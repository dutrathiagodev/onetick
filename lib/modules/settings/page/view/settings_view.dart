import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../domain/settings/entities/app_settings.dart';
import '../../../legal/legal_documents.dart';
import '../../widgets/about_card.dart';
import '../../widgets/settings_banner.dart';
import '../../widgets/settings_group.dart';
import '../../widgets/settings_row.dart';
import '../../widgets/settings_section_label.dart';
import '../../widgets/pill_switch.dart';
import '../../widgets/theme_segmented_control.dart';

/// Success scenario: grouped preference lists.
class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.settings,
    required this.isBusy,
    required this.onReminderChanged,
    required this.onReminderTimeChanged,
    required this.onThemeChanged,
    required this.onClearHistory,
    required this.onDeleteAccount,
    required this.onOpenLegal,
  });

  final AppSettings settings;
  final bool isBusy;
  final ValueChanged<bool> onReminderChanged;
  final void Function(int hour, int minute) onReminderTimeChanged;
  final ValueChanged<AppThemePreference> onThemeChanged;
  final VoidCallback onClearHistory;
  final VoidCallback onDeleteAccount;
  final ValueChanged<LegalDocument> onOpenLegal;

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.reminderHour,
        minute: settings.reminderMinute,
      ),
      helpText: 'Horário preferido',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );
    if (picked != null) onReminderTimeChanged(picked.hour, picked.minute);
  }

  Future<void> _confirmClear(BuildContext context) async {
    final confirmed = await showDangerConfirm(
      context,
      title: 'Limpar histórico e hábitos?',
      message: 'Todo o seu progresso acumulado será apagado e não poderá ser recuperado.',
      action: 'Apagar',
      keyPrefix: 'clear',
    );
    if (confirmed) onClearHistory();
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final confirmed = await showDangerConfirm(
      context,
      title: 'Excluir sua conta?',
      message:
          'Sua conta, seu histórico de focos e suas preferências serão apagados '
          'para sempre. Isso não pode ser desfeito.',
      action: 'Excluir conta',
      keyPrefix: 'delete_account',
    );
    if (confirmed) onDeleteAccount();
  }

  void _showBackupInfo(BuildContext context) =>
      showNotice(context, 'Seus dados já são salvos automaticamente na nuvem.');

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingsBanner(),
          const SizedBox(height: 24),
          const SettingsSectionLabel(
            title: 'ROTINA & HÁBITOS',
            trailing: '1x por dia',
          ),
          const SizedBox(height: 8),
          SettingsGroup(
            children: [
              SettingsRow(
                iconAsset: AppAssets.bell,
                title: 'Lembrete diário',
                subtitle: 'Notificação suave para manter o foco',
                trailing: PillSwitch(
                  key: const Key('settings_reminder_switch'),
                  value: settings.reminderEnabled,
                  semanticsLabel: 'Lembrete diário',
                  onChanged: onReminderChanged,
                ),
                onTap: () => onReminderChanged(!settings.reminderEnabled),
              ),
              SettingsRow(
                key: const Key('settings_time_row'),
                iconAsset: AppAssets.clock,
                title: 'Horário preferido',
                trailing: _TimeChip(label: settings.reminderLabel),
                onTap: () => _pickTime(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SettingsSectionLabel(title: 'APARÊNCIA & DADOS'),
          const SizedBox(height: 8),
          SettingsGroup(
            children: [
              SettingsRow(
                iconAsset: AppAssets.palette,
                title: 'Aparência',
                trailing: ThemeSegmentedControl(
                  value: settings.theme,
                  onChanged: onThemeChanged,
                ),
              ),
              SettingsRow(
                key: const Key('settings_backup_row'),
                iconAsset: AppAssets.cloudUpload,
                title: 'Backup local & Nuvem',
                subtitle: 'Sincronização automática ativa',
                chevronAsset: AppAssets.chevronRight,
                onTap: () => _showBackupInfo(context),
              ),
              SettingsRow(
                key: const Key('settings_clear_row'),
                iconAsset: AppAssets.trashRed,
                iconBackground: colors.dangerContainer.withValues(alpha: 0.3),
                title: 'Limpar histórico e hábitos',
                titleColor: colors.danger,
                subtitle: 'Reiniciar progresso acumulado',
                chevronAsset: AppAssets.chevronRightRed,
                onTap: isBusy ? null : () => _confirmClear(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SettingsSectionLabel(title: 'SOBRE'),
          const SizedBox(height: 8),
          const AboutCard(),
          const SizedBox(height: 12),
          SettingsGroup(
            children: [
              SettingsRow(
                key: const Key('settings_privacy_row'),
                iconAsset: AppAssets.lockLogin,
                title: 'Política de Privacidade',
                chevronAsset: AppAssets.chevronRight,
                onTap: () => onOpenLegal(LegalDocument.privacy),
              ),
              SettingsRow(
                key: const Key('settings_terms_row'),
                iconAsset: AppAssets.ideaBook,
                title: 'Termos de Uso',
                chevronAsset: AppAssets.chevronRight,
                onTap: () => onOpenLegal(LegalDocument.terms),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SettingsSectionLabel(title: 'CONTA'),
          const SizedBox(height: 8),
          SettingsGroup(
            children: [
              SettingsRow(
                key: const Key('settings_delete_account_row'),
                iconAsset: AppAssets.trashRed,
                iconBackground: colors.dangerContainer.withValues(alpha: 0.3),
                title: 'Excluir conta',
                titleColor: colors.danger,
                subtitle: 'Apaga a conta e todos os seus dados',
                chevronAsset: AppAssets.chevronRightRed,
                onTap: isBusy ? null : () => _confirmDeleteAccount(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surfaceMuted,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            key: const Key('settings_time_label'),
            style: AppTextStyles.labelSemi.copyWith(
              color: colors.text,
              letterSpacing: 0.325,
            ),
          ),
          const SizedBox(width: 6),
          AppIcon(AppAssets.chevronDown, tint: colors.textMuted),
        ],
      ),
    );
  }
}
