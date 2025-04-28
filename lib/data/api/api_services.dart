import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:storyq/data/model/login_response.dart';
import 'package:storyq/data/model/register_response.dart';
import 'package:storyq/data/model/story_detail_response.dart';
import 'package:storyq/data/model/story_list_response.dart';
import 'package:storyq/data/model/user.dart';
import 'package:storyq/data/model/user_login.dart';

class ApiServices {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginResponse> login(UserLogin userLogin) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userLogin.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        final message = jsonDecode(response.body)["message"];
        if (message != null) {
          throw Exception(message);
        }
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
        throw Exception(e.toString().substring(11));
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
        final message = jsonDecode(response.body)["message"];
        if (message != null) {
          throw Exception(message);
        }
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
        throw Exception(e.toString().substring(11));
      }
    }
  }

  Future<StoryListResponse> getStoryList(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/stories"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return StoryListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal untuk menampilkan daftar Story.');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet. Coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception(e.toString().substring(11));
      }
    }
  }

  Future<StoryDetailResponse> getStoryDetail(String token, String id) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/stories/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return StoryDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal untuk menampilkan detail Story.');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet. Coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception(e.toString().substring(11));
      }
    }
  }
}
