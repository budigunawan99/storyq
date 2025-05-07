import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storyq/data/model/session.dart';

class AuthRepository {
  final SharedPreferences _preferences;

  AuthRepository(this._preferences);

  static const String stateKey = 'STATE_KEY';
  static const String sessionKey = 'SESSION_KEY';

  Future<bool> login(Session session) async {
    try {
      await _preferences.setString(sessionKey, json.encode(session.toJson()));
      return _preferences.setBool(stateKey, true);
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

  Future<bool> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _preferences.setString(sessionKey, "");
      return _preferences.setBool(stateKey, false);
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

  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(seconds: 3));
    return _preferences.getBool(stateKey) ?? false;
  }

  Future<Session?> getSession() async {
    final sessionData = _preferences.getString(sessionKey) ?? "";

    Session? session;

    try {
      session = Session.fromJson(json.decode(sessionData));
    } catch (e) {
      session = null;
    }
    return session;
  }
}
