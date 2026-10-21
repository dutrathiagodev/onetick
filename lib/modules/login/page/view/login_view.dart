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
import '../../../../presenter/login/login_state.dart';
import '../../widgets/login_header.dart';

/// Success scenario of the login screen (the form). It owns only the text
/// controllers and the password visibility toggle.
class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required this.state,
    required this.onSubmit,
    required this.onGoogle,
    required this.onForgotPassword,
    required this.onInputChanged,
    required this.onGoToRegister,
  });

  final LoginState state;
  final void Function(String email, String password) onSubmit;
  final VoidCallback onGoogle;
  final ValueChanged<String> onForgotPassword;
  final VoidCallback onInputChanged;
  final VoidCallback onGoToRegister;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() => widget.onSubmit(_email.text, _password.text);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final state = widget.state;
    final busy = state.isSubmitting;
    final message = state.message;

    return SafeArea(
      child: BottomAnchoredScroll(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        top: [const SizedBox(height: 96), const LoginHeader()],
        bottom: [
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
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
                  Text(
                    'E-mail',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AuthTextField(
                    key: const Key('login_email'),
                    controller: _email,
                    hint: 'seu@email.com',
                    iconAsset: AppAssets.mailLogin,
                    iconTint: colors.textMuted,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    enabled: !busy,
                    onChanged: (_) => widget.onInputChanged(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Senha',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: colors.text,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: InkWell(
                          key: const Key('login_forgot_password'),
                          onTap: busy
                              ? null
                              : () => widget.onForgotPassword(_email.text),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Esqueceu a senha?',
                              style: AppTextStyles.caption.copyWith(
                                color: colors.textMuted.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  AuthTextField(
                    key: const Key('login_password'),
                    controller: _password,
                    hint: '••••••••',
                    iconAsset: AppAssets.lockLogin,
                    iconTint: colors.textMuted,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    enabled: !busy,
                    onChanged: (_) => widget.onInputChanged(),
                    onSubmitted: (_) => _submit(),
                    trailing: PasswordVisibilityButton(
                      visible: !_obscure,
                      assetWhenHidden: AppAssets.eyeLogin,
                      tint: colors.textMuted,
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 12),
                    AuthMessage(
                      message: message,
                      isError: state.status == LoginStatus.failure,
                    ),
                  ],
                  const SizedBox(height: 8),
                  PrimaryPillButton(
                    key: const Key('login_submit'),
                    label: 'Entrar',
                    iconAsset: AppAssets.arrowRight,
                    isLoading: busy,
                    onPressed: _submit,
                    labelStyle: AppTextStyles.labelMedium.copyWith(
                      letterSpacing: 0.325,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _SwitchToRegister(
                    onPressed: busy ? null : widget.onGoToRegister,
                  ),
                  const SizedBox(height: 8),
                  AuthDivider(
                    label: 'OU CONTINUAR COM',
                    labelStyle: AppTextStyles.overline.copyWith(
                      color: colors.textMuted,
                    ),
                    lineColor: colors.surfaceStrong,
                  ),
                  const SizedBox(height: 16),
                  GoogleButton(
                    key: const Key('login_google'),
                    iconAsset: AppAssets.google20,
                    background: colors.surfaceMuted,
                    textStyle: AppTextStyles.labelMedium.copyWith(
                      color: colors.text,
                    ),
                    onPressed: busy ? null : widget.onGoogle,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const AuthFooter(emphasized: true),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SwitchToRegister extends StatelessWidget {
  const _SwitchToRegister({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Não tem uma conta?',
          style: AppTextStyles.label.copyWith(color: colors.textMuted),
        ),
        const SizedBox(width: 6),
        InkWell(
          key: const Key('login_go_register'),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Cadastre-se',
              style: AppTextStyles.labelMedium.copyWith(
                color: colors.text,
                decoration: TextDecoration.underline,
                decorationColor: colors.outline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
