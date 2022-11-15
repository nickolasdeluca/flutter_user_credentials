import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_user_credentials/flutter_user_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('test manual data', () {
    final credentials = Credentials();
    final date = DateTime.now();

    credentials.host = 'myhost.com';
    credentials.port = 0;
    credentials.user = 'myUser';
    credentials.password = 'myPassword';
    credentials.accessToken = '<!23myR@nd0*mT0k3n';
    credentials.refreshToken = '[1ts@r3fr3shT0k3n]';
    credentials.expirationDate = date;

    expect(credentials.toJson(), {
      'host': 'myhost.com',
      'port': 0,
      'user': 'myUser',
      'password': 'myPassword',
      'accessToken': '<!23myR@nd0*mT0k3n',
      'refreshToken': '[1ts@r3fr3shT0k3n]',
      'expirationDate': date.toIso8601String()
    });
  });

  test('test import of json string', () {
    final date = DateTime.now();

    Map<String, dynamic> json = {
      'host': 'myhost.com',
      'port': 9000,
      'user': 'myUser',
      'password': 'myPassword',
      'accessToken': '<!23myR@nd0*mT0k3n',
      'expirationDate': date.toIso8601String()
    };

    final credentials = Credentials.fromJson(json);

    expect(json, credentials.toJson());
  });

  test('test save to shared preferences', () async {
    Map<String, dynamic> jsonCredentials = {
      'host': 'myhost.com',
      'user': 'myUser',
      'password': 'myPassword',
      'accessToken': '<!23myR@nd0*mT0k3n',
    };

    SharedPreferences.setMockInitialValues({});

    final credentials = Credentials.fromJson(jsonCredentials);

    await credentials.save();

    final newCredentials = await Credentials.retrieveIfExists();

    expect(newCredentials.toJson(), credentials.toJson());
  });

  test('test partially filled credentials save to shared preferences',
      () async {
    Map<String, dynamic> jsonCredentials = {
      'host': 'myhost.com',
    };

    SharedPreferences.setMockInitialValues({});

    final credentials = Credentials.fromJson(jsonCredentials);

    await credentials.save();

    final newCredentials = await Credentials.retrieveIfExists();

    expect(newCredentials.toJson(), credentials.toJson());
  });

  test('test retrieve of saved preferences', () async {
    Map<String, dynamic> jsonCredentials = {
      'host': 'myhost.com',
      'user': 'myUser',
      'password': 'myPassword',
      'accessToken': '<!23myR@nd0*mT0k3n',
    };

    SharedPreferences.setMockInitialValues(
      {'USER_CREDENTIALS': json.encode(jsonCredentials)},
    );

    Credentials credentials = await Credentials.retrieveIfExists();

    expect(credentials.toJson(), jsonCredentials);
  });
}
