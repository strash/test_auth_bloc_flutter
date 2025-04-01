final class UserModel {
  final String email;

  const UserModel({required this.email});

  UserModel copyWith({String? email}) {
    return UserModel(email: email ?? this.email);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is UserModel && email == other.email;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, email);
  }
}
