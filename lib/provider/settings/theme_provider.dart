import 'package:flutter/widgets.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool mode) {
    _isDarkMode = mode;
    notifyListeners();
  }
}
