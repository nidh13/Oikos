import 'package:flutter/material.dart';

import 'colorsConstant.dart';
class RedeemConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.blueLoading,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            ColorConstant.primaryColor,
          ),
        ),
      ),
    );
  }
}