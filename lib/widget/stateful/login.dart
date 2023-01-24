import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opticianapp/data/json_reader.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/user.dart';
import 'package:opticianapp/widget/stateful/page_slider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String? errorText = null;
  String? errorTextUserData = null;
  String userName = "Gobl";
  String password = "abcdefggfedcba";
  bool isLoginButtonPressed = false;
  BuildContext? loadingDialogContext;

  @override
  Widget build(BuildContext context) {
    setHasNetworkConnection();
    addNetworkConnectionListener();
    var loginLogo = Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Image(image: AssetImage("assets/asabit-logo.png")),
    );
    var usernameField = Padding(
      padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(DefaultProperties.defaultRounded),
            ),
            labelText: 'Benutzernamen eingeben',
            errorMaxLines: 3,
            errorStyle: TextStyle(color: Colors.red)),
        onChanged: (value) {
          userName = value;
        },
        initialValue: "Gobl",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Bitte geben Sie einen Benutzernamen ein!";
          }
          return null;
        },
      ),
    );
    //var numbers = ['0','1','2','3','4','5','6','7','8','9'];
    var passwordField = Padding(
      padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(DefaultProperties.defaultRounded),
            ),
            labelText: 'Passwort eingeben',
            errorMaxLines: 3,
            errorStyle: TextStyle(color: Colors.red)),
        onChanged: (value) {
          password = value;
        },
        initialValue: "abcdefggfedcba",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Bitte geben Sie ein Passwort ein!";
          }
          if (value.length < 12) {
            return "Bitte geben Sie ein Passwort mit mindestens 12 Zeichen ein!";
          }

          return null;
        },
        obscureText: true,
      ),
    );
    var errorTextWidget = Visibility(
      visible: errorText != null,
      child: Padding(
        padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
        child: Text(errorText ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: DefaultProperties.fontSize3, color: Colors.red)),
      ),
    );
    var errorTextWidgetCheckUserData = Visibility(
      visible: errorTextUserData != null && errorText == null,
      child: Padding(
        padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
        child: Text(errorTextUserData ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: DefaultProperties.fontSize3,
              color: Colors.red,
            )),
      ),
    );
    var loginButton = Padding(
      padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
      child: SizedBox(
        height: 75,
        width: 300,
        child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(DefaultProperties.defaultRounded))),
          ),
          child: Text("Login",
              style: TextStyle(fontSize: DefaultProperties.fontSize1)),
          onPressed: () => {onLogin()},
        ),
      ),
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                loginLogo,
                usernameField,
                passwordField,
                errorTextWidget,
                errorTextWidgetCheckUserData,
                loginButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLogin() {
    if (!_formKey.currentState!.validate() || isLoginButtonPressed) return;
    showLoadingDialog();
    isLoginButtonPressed = true;
  }

  void redirectToApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PageSlider(true)),
    );
  }

  Future<bool> checkUserData(String userName, String password) async {
    var body = jsonEncode(User(0, userName, password));

    var client = http.Client();
    try {
      var response = await client
          .post(
            Uri.parse("${DefaultProperties.serverIpAddress}/login"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 1));
      if (response.statusCode.toString().startsWith('2')) {
        var json = jsonDecode(response.body) as Map<String, dynamic>;
        if (json["userCheck"] as bool == true) {
          setState(() {
            errorTextUserData = null;
          });
          return true;
        }
        setState(() {
          errorTextUserData =
              "Diese Benutzerdaten sind ungültig oder existieren nicht!";
        });
        return false;
      } else {
        setState(() {
          errorTextUserData =
              "Es ist ein Fehler beim Verbinden zum Server aufgetreten!";
        });
        return false;
      }
    } catch (e) {
      setState(() {
        errorTextUserData =
            "Es ist ein Fehler beim Verbinden zum Server aufgetreten!";
      });
      return false;
    }
  }

  void addNetworkConnectionListener() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          errorText = "Keine Internetverbindung möglich";
        });
      } else {
        setState(() {
          errorText = null;
        });
      }
    });
  }

  Future<bool> setHasNetworkConnection() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        errorText = "Keine Internetverbindung möglich.";
      });
      return false;
    } else {
      setState(() {
        errorText = null;
      });
      return true;
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loadingDialogContext = context;
        fetchAndCheckData();
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(
                padding: EdgeInsets.all(DefaultProperties.defaultPadding),
                child: CircularProgressIndicator(),
              ),
              Text("Lade..."),
            ],
          ),
        );
      },
    );
  }

  void fetchAndCheckData() {
    setHasNetworkConnection().then((value) {
      isLoginButtonPressed = value;
      if (value) {
        checkUserData(userName, password).then((value) {
          isLoginButtonPressed = value;
          if (value) {
            JsonReader.initData().then((value) {
              isLoginButtonPressed = value;
              if (value) {
                redirectToApp();
              } else {
                closeLoadingDialog();
              }
            });
          } else {
            closeLoadingDialog();
          }
        });
      } else {
        closeLoadingDialog();
      }
    });
  }

  Future<void> closeLoadingDialog() async {
    if (loadingDialogContext == null) return;
    Navigator.pop(loadingDialogContext!);
    loadingDialogContext = null;
  }
}
