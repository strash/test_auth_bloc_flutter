import "package:test_auth_flutter/domain/model/user.dart";

abstract interface class IExternalUserRepository {
  Future<UserModel> signIn({required String email, required String password});

  Future<bool> signOut();
}
