import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:test_auth_flutter/data/external/repository/user.dart";
import "package:test_auth_flutter/domain/repository/external/user_interface.dart";
import "package:test_auth_flutter/feature/auth/page.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IExternalUserRepository>(
            create: (context) => ExternalUserRepository(),
          ),
        ],
        child: const AuthPage(),
      ),
    );
  }
}
