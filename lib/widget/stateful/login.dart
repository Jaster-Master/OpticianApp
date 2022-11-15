import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/widget/stateful/page_slider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    var loginLogo = Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Image(image: AssetImage("assets/asabit-logo.png")),
    );
    var usernameField = Padding(
      padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(DefaultProperties.defaultRounded),
          ),
          labelText: 'Benutzernamen eingeben',
        ),
      ),
    );
    var passwordField = Padding(
      padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(DefaultProperties.defaultRounded),
          ),
          labelText: 'Passwort eingeben',
        ),
        obscureText: true,
      ),
    );
    var errorTextWidget = Visibility(
      visible: errorText != null,
      child: Padding(
        padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
        child: Text(errorText ?? "",
            style: TextStyle(fontSize: DefaultProperties.fontSize1)),
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
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              loginLogo,
              usernameField,
              passwordField,
              errorTextWidget,
              loginButton,
            ],
          ),
        ),
      ),
    );
  }

  void onLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PageSlider(true)),
    );
  }
}
