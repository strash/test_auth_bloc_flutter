import "package:test_auth_flutter/domain/model/user.dart";

enum EAuthStatus { unauthorized, loading, authorized, error }

final class AuthState {
  final EAuthStatus status;
  final UserModel? user;
  final Exception? error;

  const AuthState({
    required this.status,
    required this.user,
    required this.error,
  });

  factory AuthState.init() => const AuthState(
    status: EAuthStatus.unauthorized,
    user: null,
    error: null,
  );

  AuthState copyWith({EAuthStatus? status, UserModel? user, Exception? error}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
