import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/di/screens/auth_dependencies.dart';
import '../../../main/di/service_locator.dart';
import '../../../presenter/register/register_cubit.dart';
import '../../../presenter/register/register_state.dart';
import 'view/register_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, required this.onGoToLogin});

  final VoidCallback onGoToLogin;

  @override
  Widget build(BuildContext context) {
    setupAuthDependencies();
    return BlocProvider<RegisterCubit>(
      create: (_) => getIt<RegisterCubit>(),
      child: Scaffold(
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final cubit = context.read<RegisterCubit>();
            return RegisterView(
              state: state,
              onSubmit: (name, email, password) =>
                  cubit.submit(name: name, email: email, password: password),
              onGoogle: cubit.continueWithGoogle,
              onInputChanged: cubit.clearError,
              onGoToLogin: onGoToLogin,
            );
          },
        ),
      ),
    );
  }
}
