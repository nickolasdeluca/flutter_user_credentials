import 'package:flutter/material.dart';
import 'package:flutter_user_credentials/flutter_user_credentials.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Credentials _credentials = Credentials();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _accessTokenController = TextEditingController();
  final _refreshTokenController = TextEditingController();

  _reload() async {
    Credentials reloadedCredentials = await Credentials.retrieveIfExists();

    setState(() {
      _credentials = reloadedCredentials;
    });
  }

  _save() async {
    _credentials.host = _hostController.text;
    _credentials.port = int.tryParse(_portController.text) ?? 0;
    _credentials.user = _userController.text;
    _credentials.password = _passwordController.text;
    _credentials.accessToken = _accessTokenController.text;
    _credentials.refreshToken = _refreshTokenController.text;
    _credentials.expirationDate = DateTime.now();

    await _credentials.save();
  }

  OutlineInputBorder inputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
  }

  InputDecoration _inputDecoration(String text) {
    return InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(color: Colors.white),
      border: inputBorder(),
      enabledBorder: inputBorder(),
      focusedBorder: inputBorder(),
    );
  }

  SizedBox _input(String text, TextEditingController controller) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        decoration: _inputDecoration(
          text,
        ),
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(255, 11, 46, 107),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Input your data",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: constraints.maxWidth - 100,
                      child: Column(
                        children: [
                          _input("Host", _hostController),
                          const SizedBox(
                            height: 5,
                          ),
                          _input("Port", _portController),
                          const SizedBox(
                            height: 5,
                          ),
                          _input("User", _userController),
                          const SizedBox(
                            height: 5,
                          ),
                          _input("Password", _passwordController),
                          const SizedBox(
                            height: 5,
                          ),
                          _input("AccessToken", _accessTokenController),
                          const SizedBox(
                            height: 5,
                          ),
                          _input("RefreshToken", _refreshTokenController),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Stored data",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: constraints.maxWidth - 100,
                            height: (constraints.maxHeight / 10) * 3,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Host: ${_credentials.host}"),
                                    Text("Port: ${_credentials.port}"),
                                    Text("User: ${_credentials.user}"),
                                    Text("Password: ${_credentials.password}"),
                                    Text(
                                        "AccessToken: ${_credentials.accessToken}"),
                                    Text(
                                        "RefreshToken: ${_credentials.refreshToken}"),
                                    Text(
                                        "Date: ${_credentials.expirationDate}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: ElevatedButton(
                                  onPressed: _save,
                                  child: const Text('Save'),
                                ),
                              ),
                              Flexible(
                                child: ElevatedButton(
                                  onPressed: _reload,
                                  child: const Text('Load stored data'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
