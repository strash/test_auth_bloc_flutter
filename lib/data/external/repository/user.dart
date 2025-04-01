import "package:flutter/foundation.dart";
import "package:test_auth_flutter/domain/model/user.dart";
import "package:test_auth_flutter/domain/repository/external/user_interface.dart";

final class ExternalUserRepository implements IExternalUserRepository {
  @override
  Future<UserModel> signIn({required String email, required String password}) {
    // Тут должна быть реальная логика отправки запроса и получения
    // авторизованного пользователя вместе с токенами (зависит от API).
    // Если пришли токены, то сохраняем их в хранилище для будущего
    // использования в других запросах.
    return Future.value(UserModel(email: email));
  }

  @override
  Future<bool> signOut() async {
    // Тут тоже должен быть реальный запрос к API. Если удачный, чистим
    // хранилище от токенов.
    if (kDebugMode) print("OK");
    return true;
  }
}
