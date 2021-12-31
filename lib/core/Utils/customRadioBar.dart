import 'package:flutter/material.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomRadioBar extends StatelessWidget {
  final int groupValue;
  final Function onChangedYes;
  final Function onChangedNo;
  final String text;

  CustomRadioBar({this.groupValue,this.onChangedNo,this.onChangedYes,this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CustomText(
            value: text,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: ColorConstant.darkText,
          ),
        ),
        SizedBox(height: 2,),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Radio(
                value: 1,
                groupValue: groupValue,
                activeColor: ColorConstant.primaryColor,
                onChanged: onChangedYes
              ),
              CustomText(
                value: "Oui",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorConstant.gray,
              ),
              SizedBox(width: 50,),
              Radio(
                value: 2,
                groupValue: groupValue,
                activeColor: ColorConstant.primaryColor,
                onChanged: onChangedNo,
              ),
              CustomText(
                value: "Non",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorConstant.gray,
              )
            ],
          ),
        )
      ],
    );
  }
}
