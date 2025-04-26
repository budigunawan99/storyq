import 'package:flutter/widgets.dart';
import 'package:storyq/data/local/theme_shared_preferences_service.dart';

class ThemeSharedPreferencesProvider extends ChangeNotifier {
  final ThemeSharedPreferencesService _service;

  ThemeSharedPreferencesProvider(this._service);

  String _message = "";
  String get message => _message;

  bool? _currentTheme;
  bool? get currentTheme => _currentTheme;

  Future<void> saveTheme(bool theme) async {
    try {
      await _service.saveTheme(theme);
      _message = "Mode tema anda sudah tersimpan";
    } catch (e) {
      _message = "Mode tema anda gagal tersimpan";
    }
    notifyListeners();
  }

  void getTheme() async {
    try {
      _currentTheme = _service.getTheme();
      _message = "Berhasil loading tema";
    } catch (e) {
      _message = "Gagal loading tema";
    }
    notifyListeners();
  }
}
