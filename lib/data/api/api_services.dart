import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:storyq/data/model/login_response.dart';
import 'package:storyq/data/model/register_response.dart';
import 'package:storyq/data/model/user.dart';

class ApiServices {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginResponse> login(User user) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal mengautentikasi data.');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet. Coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<RegisterResponse> register(User user) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal mengautentikasi data.');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet. Coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }
}
