import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double minWidth;
  final String text;
  final Function onPressed;
  final FontWeight fontWeight;
  final double fontSize;
  final double letterSpacing;

  CustomButton({this.height, this.minWidth, this.text, this.onPressed,this.fontWeight,this.letterSpacing,this.fontSize});

  @override
  Widget build(BuildContext context) {
    if(minWidth !=null){
      return ButtonTheme(
        height: height,
        minWidth: minWidth,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: RaisedButton(
          color: ColorConstant.primaryColor,
          child: CustomText(
            value:text,
            color: ColorConstant.white,
            fontSize:fontSize,
            fontWeight: fontWeight,
            letterSpacing:  letterSpacing,
          ),
          onPressed: onPressed,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30 ),
      child: Container(
        width: double.infinity,
        child: ButtonTheme(
          height: height,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: RaisedButton(
            color: ColorConstant.primaryColor,
            child: CustomText(
              value:text,
              color: ColorConstant.white,
              fontSize:fontSize,
              fontWeight: fontWeight,
              letterSpacing:  letterSpacing,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
