import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:test_auth_flutter/app/input_contoller.dart";
import "package:test_auth_flutter/app/validator/email.dart";
import "package:test_auth_flutter/app/view_model.dart";
import "package:test_auth_flutter/feature/auth/bloc.dart";
import "package:test_auth_flutter/feature/auth/event.dart";
import "package:test_auth_flutter/feature/auth/view.dart";

final class AuthViewModelProvider extends StatefulWidget {
  const AuthViewModelProvider({super.key});

  @override
  ViewModelState<AuthViewModelProvider> createState() => AuthViewModel();
}

final class AuthViewModel extends ViewModelState<AuthViewModelProvider> {
  final emailController = InputController(validators: [EmailValidator()]);
  final passwordController = InputController();
  bool isPasswordVisible = true;
  bool isSubmitEnabled = false;

  bool isDebugErrorEnabled = false;

  void onPasswordVisibilityToggled() {
    setState(() => isPasswordVisible = !isPasswordVisible);
  }

  void onSignInPressed() {
    context.read<AuthBloc>().add(
      AuthEventSignInRequested(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        debugShowError: isDebugErrorEnabled,
      ),
    );
  }

  void onSignOutPressed() {
    context.read<AuthBloc>().add(AuthEventSignOutRequested());
  }

  void onDebugErrorToggled(bool value) {
    setState(() => isDebugErrorEnabled = value);
  }

  void _validator() {
    setState(() {
      isSubmitEnabled =
          emailController.text.isNotEmpty &&
          emailController.isValid &&
          passwordController.text.isNotEmpty &&
          passwordController.isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validator);
    passwordController.addListener(_validator);
  }

  @override
  void dispose() {
    emailController.removeListener(_validator);
    passwordController.removeListener(_validator);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<AuthViewModel>(viewModel: this, child: const AuthView());
  }
}
