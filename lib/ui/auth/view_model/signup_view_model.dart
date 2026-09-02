import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/services/auth_service.dart';

enum SignUpStatus { idle, loading, success, error }

class SignUpViewModel extends ChangeNotifier {
  final _authService = AuthService();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isPasswordVisible = false;
  SignUpStatus _status = SignUpStatus.idle;
  String? _errorMessage;

  SignUpStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == SignUpStatus.loading;
  bool get isPasswordVisible => _isPasswordVisible;

  void onEmailChanged(String v) {
    _email = v;
    _clearError();
  }

  void onPasswordChanged(String v) {
    _password = v;
    _clearError();
  }

  void onConfirmPasswordChanged(String v) {
    _confirmPassword = v;
    _clearError();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void _clearError() {
    if (_status == SignUpStatus.error) {
      _status = SignUpStatus.idle;
      _errorMessage = null;
    }
    notifyListeners();
  }

  Future<void> signUp() async {
    if (_email.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      _setError('Please fill in all fields.');
      return;
    }
    if (_password != _confirmPassword) {
      _setError('Passwords do not match.');
      return;
    }
    if (_password.length < 6) {
      _setError('Password must be at least 6 characters.');
      return;
    }

    _status = SignUpStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signUpWithEmail(_email, _password);
      _status = SignUpStatus.success;
    } on AuthException catch (e) {
      _setError(_parseAuthError(e.message));
    } catch (_) {
      _setError('An unexpected error occurred. Please try again.');
    }
    notifyListeners();
  }

  void _setError(String message) {
    _status = SignUpStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  String _parseAuthError(String message) {
    if (message.contains('already registered') || message.contains('already been registered')) {
      return 'An account with this email already exists.';
    }
    if (message.contains('invalid email')) {
      return 'Please enter a valid email address.';
    }
    return message;
  }
}
