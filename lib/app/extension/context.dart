import "package:flutter/widgets.dart";
import "package:test_auth_flutter/app/view_model.dart";

extension BuildContextEx on BuildContext {
  T viewModel<T extends ViewModelState<StatefulWidget>>() {
    return ViewModel.of<T>(this);
  }
}
