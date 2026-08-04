import 'package:flutter/foundation.dart';

enum LoginStatus { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;
  LoginStatus _status = LoginStatus.idle;
  String? _errorMessage;

  String get email => _email;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;
  LoginStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == LoginStatus.loading;

  void onEmailChanged(String value) {
    _email = value;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _password = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      _errorMessage = 'Por favor completa todos los campos';
      _status = LoginStatus.error;
      notifyListeners();
      return;
    }

    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    // TODO: conectar con servicio de autenticación real
    await Future.delayed(const Duration(milliseconds: 1200));

    _status = LoginStatus.success;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    // TODO: implementar Google Sign In
  }

  Future<void> loginWithApple() async {
    // TODO: implementar Apple Sign In
  }
}
