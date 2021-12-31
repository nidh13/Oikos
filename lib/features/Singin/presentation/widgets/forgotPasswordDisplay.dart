import 'package:flutter/material.dart';

class ForgotPasswordDisplay extends StatefulWidget {
  @override
  _ForgotPasswordDisplayState createState() => _ForgotPasswordDisplayState();
}

class _ForgotPasswordDisplayState extends State<ForgotPasswordDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("forgetPassword screen"),
        ),
      ),
    );
  }
}
