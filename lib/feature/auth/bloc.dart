import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:test_auth_flutter/domain/repository/external/user_interface.dart";
import "package:test_auth_flutter/feature/auth/event.dart";
import "package:test_auth_flutter/feature/auth/state.dart";

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IExternalUserRepository _userRepo;

  AuthBloc(this._userRepo) : super(AuthState.init()) {
    on<AuthEventSignInRequested>(_onSignIn);
    on<AuthEventSignOutRequested>(_onSignOut);
  }

  Future<void> _onSignIn(
    AuthEventSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: EAuthStatus.loading));

    await Future.delayed(const Duration(seconds: 2), () {});
    try {
      if (event.debugShowError) {
        emit(
          state.copyWith(status: EAuthStatus.error, error: Exception("Error")),
        );
      } else {
        final user = await _userRepo.signIn(
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: EAuthStatus.authorized, user: user));
      }
    } catch (e) {
      if (kDebugMode) print(e);
      emit(state.copyWith(status: EAuthStatus.error, error: e as Exception));
    }
  }

  Future<void> _onSignOut(
    AuthEventSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (await _userRepo.signOut()) {
        emit(state.copyWith(status: EAuthStatus.unauthorized));
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
}
