import 'package:flutter/material.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomSwitch extends StatelessWidget {
  final bool isSwitched;
  final String text ;
  final Function onChanged;


  CustomSwitch({this.isSwitched, this.text, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
            value: isSwitched,
            activeColor: ColorConstant.primaryColor,
            onChanged:onChanged ),
        CustomText(value: text,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: ColorConstant.darkText,
        )
      ],
    );
  }
}
