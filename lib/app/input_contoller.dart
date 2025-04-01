import "package:flutter/widgets.dart";

enum EInputValidationStrategy { any, all }

abstract interface class IInputValidator {
  String? call(String? value);
}

final class InputController {
  final key = GlobalKey<FormFieldState>();
  final focus = FocusNode();
  final controller = TextEditingController();
  final EInputValidationStrategy validationStrategy;
  List<IInputValidator> validators;

  String get text => controller.text;

  set text(String value) => controller.text = value;

  bool get isValid {
    return validator(text)?.isEmpty ?? true;
  }

  InputController({
    this.validators = const [],
    this.validationStrategy = EInputValidationStrategy.any,
  });

  void addListener(VoidCallback listener) {
    controller.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    controller.removeListener(listener);
  }

  void addValidator<T extends IInputValidator>(T validator) {
    if (!validators.any((e) => e is T)) {
      validators = List<T>.from(validators)..add(validator);
    }
  }

  void removeValidator<T extends IInputValidator>() {
    validators = List<T>.from(validators.where((e) => e is! T));
  }

  void onTapOutside(PointerDownEvent event) {
    if (focus.hasFocus) {
      validator(text);
      focus.unfocus();
    }
  }

  String? validator(String? value) {
    return switch (validationStrategy) {
      EInputValidationStrategy.any => _anyStrategy(value),
      EInputValidationStrategy.all => _allStrategy(value),
    };
  }

  void dispose() {
    focus.dispose();
    controller.dispose();
  }

  String? _anyStrategy(String? value) {
    if (validators.isEmpty) return null;
    final List<String?> res = [];
    for (final item in validators) {
      res.add(item(value));
    }
    if (res.contains(null)) return null;
    return res.firstWhere((e) => e != null);
  }

  String? _allStrategy(String? value) {
    if (validators.isEmpty) return null;
    for (final item in validators) {
      final res = item(value);
      if (res != null) return res;
    }
    return null;
  }
}
