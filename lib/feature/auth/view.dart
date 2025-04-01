import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:test_auth_flutter/app/extension/context.dart";
import "package:test_auth_flutter/feature/auth/bloc.dart";
import "package:test_auth_flutter/feature/auth/state.dart";
import "package:test_auth_flutter/feature/auth/view_model.dart";

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.viewModel<AuthViewModel>();

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (state.status) {
            case EAuthStatus.unauthorized ||
                EAuthStatus.loading ||
                EAuthStatus.error:
              return CustomScrollView(
                slivers: [
                  // -> appbar
                  const SliverAppBar(pinned: true, title: Text("Авторизация")),

                  // -> form
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // -> email input
                            TextFormField(
                              key: viewModel.emailController.key,
                              focusNode: viewModel.emailController.focus,
                              controller: viewModel.emailController.controller,
                              validator: viewModel.emailController.validator,
                              enabled: state.status != EAuthStatus.loading,
                              onTapOutside:
                                  viewModel.emailController.onTapOutside,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              maxLength: 15,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                            ),
                            const SizedBox(height: 10.0),

                            // -> password input
                            TextFormField(
                              key: viewModel.passwordController.key,
                              focusNode: viewModel.passwordController.focus,
                              controller:
                                  viewModel.passwordController.controller,
                              validator: viewModel.passwordController.validator,
                              enabled: state.status != EAuthStatus.loading,
                              onTapOutside:
                                  viewModel.passwordController.onTapOutside,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.send,
                              maxLength: 15,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              onFieldSubmitted: (value) {
                                viewModel.onSignInPressed();
                              },
                              obscureText: !viewModel.isPasswordVisible,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: viewModel.onPasswordVisibilityToggled,
                                  child: Icon(
                                    viewModel.isPasswordVisible
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),

                            // -> submit
                            FilledButton(
                              onPressed:
                                  state.status != EAuthStatus.loading &&
                                          viewModel.isSubmitEnabled
                                      ? viewModel.onSignInPressed
                                      : null,
                              child: const Text("Войти"),
                            ),

                            // -> loader
                            if (state.status == EAuthStatus.loading)
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Center(
                                  child: SizedBox.square(
                                    dimension: 30.0,
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                ),
                              ),

                            // -> error message
                            const SizedBox(height: 20.0),
                            if (state.status == EAuthStatus.error)
                              Text(
                                "Упс! Что-то пошло не так. "
                                "Попробуйте заново.",
                                style: TextTheme.of(
                                  context,
                                ).bodyMedium?.copyWith(
                                  color: ColorScheme.of(context).error,
                                ),
                              ),

                            // -> debug switcher
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                viewModel.onDebugErrorToggled(
                                  !viewModel.isDebugErrorEnabled,
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Вызвать ошибку"),
                                  Switch.adaptive(
                                    value: viewModel.isDebugErrorEnabled,
                                    onChanged: viewModel.onDebugErrorToggled,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );

            case EAuthStatus.authorized:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Вы авторизованы",
                      style: TextTheme.of(context).headlineLarge,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Привет, ${state.user?.email}!",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                    const SizedBox(height: 30.0),
                    FilledButton(
                      onPressed: viewModel.onSignOutPressed,
                      child: const Text("Выйти"),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
