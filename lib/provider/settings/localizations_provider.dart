import 'package:flutter/widgets.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale("id");
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
