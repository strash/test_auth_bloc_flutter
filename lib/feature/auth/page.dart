import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:test_auth_flutter/domain/repository/external/user_interface.dart";
import "package:test_auth_flutter/feature/auth/bloc.dart";
import "package:test_auth_flutter/feature/auth/view_model.dart";

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(context.read<IExternalUserRepository>()),
      child: const AuthViewModelProvider(),
    );
  }
}
