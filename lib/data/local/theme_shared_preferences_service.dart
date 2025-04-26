import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPreferencesService {
  final SharedPreferences _preferences;

  ThemeSharedPreferencesService(this._preferences);

  static const String themeKey = 'STORYQ_THEME';

  Future<void> saveTheme(bool currentTheme) async {
    try {
      await _preferences.setBool(themeKey, currentTheme);
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  bool getTheme() {
    return _preferences.getBool(themeKey) ?? false;
  }
}
