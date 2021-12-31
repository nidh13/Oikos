import 'package:flutter/material.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomRadioButton extends StatelessWidget {
  final bool checked;
  final Function onTap;
  final String text;

  CustomRadioButton({this.checked, this.onTap,this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: checked?ColorConstant.primaryColor: Color(0xFFE9ECF2),
        ),
        child: CustomText(
          value:text,
          color:checked? ColorConstant.white: Color(0xFF272727),
          fontSize:12,
          fontWeight: FontWeight.w600,

        ),
      ),
    );
  }
}
