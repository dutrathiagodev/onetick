import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/bottom_anchored_scroll.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth/auth_divider.dart';
import '../../../../core/widgets/auth/auth_footer.dart';
import '../../../../core/widgets/auth/auth_message.dart';
import '../../../../core/widgets/auth/auth_text_field.dart';
import '../../../../core/widgets/auth/google_button.dart';
import '../../../../core/widgets/primary_pill_button.dart';
import '../../../../presenter/register/register_state.dart';
import '../../widgets/commitment_check.dart';
import '../../widgets/register_header.dart';

/// Success scenario of the sign-up screen (the form).
class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    required this.state,
    required this.onSubmit,
    required this.onGoogle,
    required this.onInputChanged,
    required this.onGoToLogin,
  });

  final RegisterState state;
  final void Function(String name, String email, String password) onSubmit;
  final VoidCallback onGoogle;
  final VoidCallback onInputChanged;
  final VoidCallback onGoToLogin;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscure = true;
  bool _commitment = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() => widget.onSubmit(_name.text, _email.text, _password.text);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final state = widget.state;
    final busy = state.isSubmitting;
    final fieldText = AppTextStyles.label.copyWith(
      fontSize: 14,
      height: 20 / 14,
    );
    final labelStyle = AppTextStyles.label.copyWith(
      fontWeight: FontWeight.w500,
      height: 19.5 / 13,
      color: colors.text,
    );

    return SafeArea(
      child: BottomAnchoredScroll(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
        top: [const RegisterHeader()],
        bottom: [
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colors.inverse.withValues(alpha: 0.05)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Nome completo', style: labelStyle),
                  const SizedBox(height: 4),
                  AuthTextField(
                    key: const Key('register_name'),
                    controller: _name,
                    hint: 'Como quer ser chamado?',
                    iconAsset: AppAssets.userField,
                    radius: 16,
                    verticalPadding: 13.5,
                    textStyle: fieldText,
                    hintColor: colors.placeholder,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    enabled: !busy,
                    onChanged: (_) => widget.onInputChanged(),
                  ),
                  const SizedBox(height: 10),
                  Text('E-mail', style: labelStyle),
                  const SizedBox(height: 4),
                  AuthTextField(
                    key: const Key('register_email'),
                    controller: _email,
                    hint: 'seu@email.com',
                    iconAsset: AppAssets.mailRegister,
                    radius: 16,
                    verticalPadding: 13.5,
                    textStyle: fieldText,
                    hintColor: colors.placeholder,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    enabled: !busy,
                    onChanged: (_) => widget.onInputChanged(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Senha', style: labelStyle),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Mínimo 8 caracteres',
                          textAlign: TextAlign.end,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 11,
                            height: 16.5 / 11,
                            fontWeight: FontWeight.w500,
                            color: colors.placeholder,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AuthTextField(
                    key: const Key('register_password'),
                    controller: _password,
                    hint: 'Mínimo 8 caracteres',
                    iconAsset: AppAssets.lockRegister,
                    radius: 16,
                    verticalPadding: 13.5,
                    textStyle: fieldText,
                    hintColor: colors.placeholder,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    enabled: !busy,
                    onChanged: (_) => widget.onInputChanged(),
                    onSubmitted: (_) => _submit(),
                    trailing: PasswordVisibilityButton(
                      visible: !_obscure,
                      assetWhenHidden: AppAssets.eyeRegister,
                      tint: colors.placeholder,
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CommitmentCheck(
                    checked: _commitment,
                    onChanged: (value) => setState(() => _commitment = value),
                  ),
                  if (state.message != null) ...[
                    const SizedBox(height: 10),
                    AuthMessage(message: state.message!),
                  ],
                  const SizedBox(height: 6),
                  PrimaryPillButton(
                    key: const Key('register_submit'),
                    label: 'Criar conta',
                    iconAsset: AppAssets.arrowRight,
                    height: 48,
                    isLoading: busy,
                    onPressed: _submit,
                    labelStyle: AppTextStyles.labelSemi.copyWith(
                      fontSize: 14,
                      letterSpacing: 0.35,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Já tem uma conta?',
                        style: AppTextStyles.label.copyWith(
                          color: colors.textFaint,
                          height: 19.5 / 13,
                        ),
                      ),
                      InkWell(
                        key: const Key('register_go_login'),
                        onTap: busy ? null : widget.onGoToLogin,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 12,
                          ),
                          child: Text(
                            'Entrar',
                            style: AppTextStyles.labelSemi.copyWith(
                              letterSpacing: 0,
                              height: 19.5 / 13,
                              color: colors.text,
                              decoration: TextDecoration.underline,
                              decorationColor: colors.outline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  AuthDivider(
                    label: 'OU CONTINUAR COM',
                    labelStyle: AppTextStyles.overline.copyWith(
                      fontSize: 10.5,
                      height: 15.75 / 10.5,
                      letterSpacing: 0.525,
                      color: colors.placeholder,
                    ),
                    lineColor: colors.border,
                  ),
                  const SizedBox(height: 14),
                  GoogleButton(
                    key: const Key('register_google'),
                    iconAsset: AppAssets.google16,
                    height: 44,
                    gap: 10,
                    background: colors.surface,
                    borderColor: colors.border,
                    textStyle: AppTextStyles.label.copyWith(
                      fontSize: 13.5,
                      height: 20.25 / 13.5,
                      fontWeight: FontWeight.w500,
                      color: colors.text,
                    ),
                    onPressed: busy ? null : widget.onGoogle,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const AuthFooter(),
        ],
      ),
    );
  }
}
