import 'package:flutter/material.dart';
import '../ui/auth/view/login_screen.dart';
import '../ui/auth/view/signup_screen.dart';
import '../ui/shell/view/shell_screen.dart';

class AppRouter {
  static const String login = '/';
  static const String shell = '/home';
  static const String signup = '/signup';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case shell:
        return MaterialPageRoute(builder: (_) => const ShellScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Página no encontrada')),
          ),
        );
    }
  }
}
