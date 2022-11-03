import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/widget/stateful/login.dart';

void main(){
  runApp(const OpticianApp());
}

class OpticianApp extends StatelessWidget{
  const OpticianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: LoginView(),
      ),
    );
  }
}