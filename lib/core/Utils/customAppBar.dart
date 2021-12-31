import 'package:flutter/material.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconButton leading;
  final Widget action ;


  CustomAppBar({this.title, this.leading, this.action});

  @override
  Widget build(BuildContext context) {
    return           Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(

            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[ ColorConstant.gradientAppBar,ColorConstant.gradientAppBar1,ColorConstant.blue,],
            stops: [0.0,0.5,1]
        ),
        //  shape: BoxShape.circle,
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CustomText(
            value: title,
            letterSpacing: 0.5,
            color: ColorConstant.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: leading,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20,right: 10),
            child: action,
          )
        ],
      ),
    );
  }
}
