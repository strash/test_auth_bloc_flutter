sealed class AuthEvent {
  const AuthEvent();
}

final class AuthEventSignInRequested extends AuthEvent {
  final String email;
  final String password;
  final bool debugShowError;

  const AuthEventSignInRequested({
    required this.email,
    required this.password,
    required this.debugShowError,
  });
}

final class AuthEventSignOutRequested extends AuthEvent {}
