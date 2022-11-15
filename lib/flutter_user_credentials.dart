library flutter_user_credentials;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const _kKeyName = 'USER_CREDENTIALS';

class Credentials {
  String? host;
  int? port;
  String? user;
  String? password;
  String? accessToken;
  String? refreshToken;
  DateTime? expirationDate;

  Credentials({
    String? host,
    int? port,
    String? user,
    String? password,
    String? accessToken,
    String? refreshToken,
    DateTime? expirationDate,
  });

  static Future<Credentials> retrieveIfExists() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(_kKeyName)) {
      return Credentials.fromJson(
        json.decode(preferences.getString(_kKeyName)!),
      );
    }

    return Credentials();
  }

  save() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(_kKeyName, json.encode(toJson()));
  }

  factory Credentials.fromJson(Map<String, dynamic> json) {
    Credentials credentials = Credentials();

    credentials.host = json['host'];
    credentials.port = json['port'];
    credentials.user = json['user'];
    credentials.password = json['password'];
    credentials.accessToken = json['accessToken'];
    credentials.refreshToken = json['refreshToken'];
    credentials.expirationDate = DateTime.tryParse(
      json['expirationDate'].toString(),
    );

    return credentials;
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
      'user': user,
      'password': password,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expirationDate': expirationDate?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }
}
