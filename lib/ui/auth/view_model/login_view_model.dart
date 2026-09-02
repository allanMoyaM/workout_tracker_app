import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/services/auth_service.dart';

enum LoginStatus { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
  final _authService = AuthService();

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
    if (_status == LoginStatus.error) {
      _status = LoginStatus.idle;
      _errorMessage = null;
    }
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _password = value;
    if (_status == LoginStatus.error) {
      _status = LoginStatus.idle;
      _errorMessage = null;
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void reset() {
    _status = LoginStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      _status = LoginStatus.error;
      notifyListeners();
      return;
    }

    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signInWithEmail(_email, _password);
      _status = LoginStatus.success;
    } on AuthException catch (e) {
      _status = LoginStatus.error;
      _errorMessage = _parseAuthError(e.message);
    } catch (_) {
      _status = LoginStatus.error;
      _errorMessage = 'An unexpected error occurred. Please try again.';
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } on AuthException catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  Future<void> loginWithApple() async {
    try {
      await _authService.signInWithApple();
    } on AuthException catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  Future<bool> sendPasswordReset(String email) async {
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (_) {
      return false;
    }
  }

  String _parseAuthError(String message) {
    if (message.contains('Invalid login credentials')) {
      return 'Incorrect email or password.';
    }
    if (message.contains('Email not confirmed')) {
      return 'Please confirm your email before logging in.';
    }
    if (message.contains('Too many requests')) {
      return 'Too many attempts. Please wait a moment.';
    }
    return message;
  }
}
