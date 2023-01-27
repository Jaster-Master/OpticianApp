import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/model/user.dart';
import 'package:opticianapp/notification/notification_service.dart';
import 'package:opticianapp/widget/stateful/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializeService();
  runApp(OpticianApp());
}

class OpticianApp extends StatelessWidget {
  static User? user;

  OpticianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: MaterialColor(0xFF4525f2, const {
          50: const Color(0xFF4525f2),
          100: const Color(0xFF4525f2),
          200: const Color(0xFF4525f2),
          300: const Color(0xFF4525f2),
          400: const Color(0xFF4525f2),
          500: const Color(0xFF4525f2),
          600: const Color(0xFF4525f2),
          700: const Color(0xFF4525f2),
          800: const Color(0xFF4525f2),
          900: const Color(0xFF4525f2)
        }),
      ),
      home: SafeArea(
        child: LoginView(),
      ),
    );
  }
}
