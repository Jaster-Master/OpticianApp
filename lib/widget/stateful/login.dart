import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/notification/notificationHandler.dart';
import 'package:opticianapp/notification/notificationService.dart';
import 'package:opticianapp/sth.dart';
import 'package:opticianapp/widget/stateful/home.dart';
import 'package:opticianapp/widget/stateful/pageSlider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(Sth.morePadding),
                  child: Image(image: AssetImage("assets/asabit-logo.png")),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sth.defaultPadding),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sth.defaultRounded),
                      ),
                      labelText: 'Enter your username',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Sth.defaultPadding),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sth.defaultRounded),
                      ),
                      labelText: 'Enter your password',
                    ),
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Padding(
                    padding: EdgeInsets.all(Sth.defaultPadding),
                    child: Text(errorText ?? ""),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Sth.defaultPadding),
                  child: SizedBox(
                    height: 75,
                    width: 300,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sth.defaultRounded))),
                      ),
                      child: const Text("Login",
                          style: TextStyle(fontSize: Sth.fontSize1)),
                      onPressed: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PageSlider()),
                        )
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
