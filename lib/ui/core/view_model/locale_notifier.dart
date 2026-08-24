import 'package:flutter/material.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  bool get isEnglish => _locale.languageCode == 'en';

  void toggle() {
    _locale = isEnglish ? const Locale('es') : const Locale('en');
    notifyListeners();
  }
}
