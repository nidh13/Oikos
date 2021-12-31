import 'package:flutter/material.dart';

class RobotoText extends StatelessWidget {
  final  String value;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines ;
  final bool softWrap;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final double letterSpacing;
  final double height;

  RobotoText({this.value, this.fontSize, this.color, this.fontWeight,
    this.overflow, this.maxLines, this.softWrap, this.textAlign,
    this.decoration, this.letterSpacing, this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      overflow: overflow,
      maxLines: maxLines,
      textScaleFactor: 1.0,
      textAlign: textAlign,
      softWrap: softWrap,

      style: TextStyle(
        decoration: decoration,
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
        fontSize: fontSize ,
        color: color ,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
