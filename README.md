# flutter_user_credentials

[![Pub Version](https://img.shields.io/pub/v/flutter_user_credentials?color=blue&label=pub.dev)](https://pub.dev/packages/flutter_user_credentials) [![GitHub Release Date](https://img.shields.io/github/release-date/nickolasdeluca/flutter_user_credentials)](https://github.com/nickolasdeluca/flutter_user_credentials) ![GitHub issues](https://img.shields.io/github/issues-raw/nickolasdeluca/flutter_user_credentials)

A simple handler for user credentials that can be easily stored and retrieved

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :----: |
|   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️   |

## Usage

### You can instantiate it manually

``` dart
  final credentials = Credentials();
  final date = DateTime.now();

  credentials.host = 'myhost.com';
  credentials.port = 0;
  credentials.user = 'myUser';
  credentials.password = 'myPassword';
  credentials.accessToken = '<!23myR@nd0*mT0k3n';
  credentials.refreshToken = '[1ts@r3fr3shT0k3n]';
  credentials.expirationDate = date;
```

### You can instantiate it from a json object

``` dart
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
```

### Saving it to shared preferences

``` dart
  final date = DateTime.now();

  Map<String, dynamic> json = {
    'host': 'myhost.com',
    'port': 9000,
    'user': 'myUser',
    'password': 'myPassword',
    'accessToken': '<!23myR@nd0*mT0k3n',
    'expirationDate': date.toIso8601String()
  };

  await credentials.save();
```

`This method is async, it is recommended that you wait for it before continuing`

### You can retrieve saved values

``` dart
  Credentials credentials = await credentials.retrieveIfExists();
```

`This method is async, it is recommended that you wait for it before continuing`

### You can clear all attributes of a credential

``` dart
  credentials.clear();
```

### You can purge credentials from shared preferences through a static method

``` dart
  await Credentials.purge();
```

`This method is async, it is recommended that you wait for it before continuing`
