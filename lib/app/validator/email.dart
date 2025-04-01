import "package:test_auth_flutter/app/input_contoller.dart";

const _pattern = r"^[\w\-\.]+@(?:[\w-]+\.)+[\w-]{2,}$";

final class EmailValidator implements IInputValidator {
  final _regex = RegExp(_pattern);

  @override
  String? call(String? value) {
    if (value != null &&
        value.trim().isNotEmpty &&
        _regex.hasMatch(value.trim())) {
      return null;
    }
    return "Это не почта";
  }
}
