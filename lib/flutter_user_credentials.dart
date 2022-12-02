/// A flutter library to handle user credentials
library flutter_user_credentials;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const _kKeyName = 'USER_CREDENTIALS';

/// Wrapper class to handle data.
class Credentials {
  String? host;
  int? port;
  String? user;
  String? password;
  String? accessToken;
  String? refreshToken;
  DateTime? expirationDate;

  /// Constructor can be empty or you can pass through your data.
  ///
  /// All values are optional since there are many types of credentials.
  ///
  /// The value [expirationDate] should be stored as Iso8601String, although you can use other formats if they are compatible.
  Credentials({
    this.host,
    this.port,
    this.user,
    this.password,
    this.accessToken,
    this.refreshToken,
    this.expirationDate,
  });

  /// Retrieves stored data if it exists, if it doesn't, runs an empty constructor.
  ///
  /// Data is stored under the key [USER_CREDENTIALS].
  static Future<Credentials> retrieveIfExists() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(_kKeyName)) {
      return Credentials.fromJson(
        json.decode(preferences.getString(_kKeyName)!),
      );
    }

    return Credentials();
  }

  /// Saves data to Shared Preferences.
  ///
  /// Data is stored under the key [USER_CREDENTIALS].
  save() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(_kKeyName, json.encode(toJson()));
  }

  /// Parses a JSON Object to a Credentials Object
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

  /// Parses a Credentials Object to a JSON Object
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
