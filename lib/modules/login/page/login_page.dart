import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/di/screens/auth_dependencies.dart';
import '../../../main/di/service_locator.dart';
import '../../../presenter/login/login_cubit.dart';
import '../../../presenter/login/login_state.dart';
import 'view/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onGoToRegister});

  final VoidCallback onGoToRegister;

  @override
  Widget build(BuildContext context) {
    setupAuthDependencies();
    return BlocProvider<LoginCubit>(
      create: (_) => getIt<LoginCubit>(),
      child: Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();
            return LoginView(
              state: state,
              onSubmit: (email, password) =>
                  cubit.submit(email: email, password: password),
              onGoogle: cubit.continueWithGoogle,
              onForgotPassword: cubit.forgotPassword,
              onInputChanged: cubit.clearError,
              onGoToRegister: onGoToRegister,
            );
          },
        ),
      ),
    );
  }
}
