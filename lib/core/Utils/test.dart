import 'package:flutter/material.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomRadioBar extends StatefulWidget {
  final String text;
  CustomRadioBar(this.text);
  @override
  _CustomRadioBarState createState() => _CustomRadioBarState();
}

class _CustomRadioBarState extends State<CustomRadioBar> {
  int _groupValue = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CustomText(
            value: widget.text,
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
                groupValue: _groupValue,
                activeColor: Colors.green,
                onChanged: (val) {
                  print("Radio $val");
                  setState(() => _groupValue = val);
                },
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
                groupValue: _groupValue,
                activeColor: Colors.green,
                onChanged: (val) {
                  print("Radio $val");
                  setState(() => _groupValue = val);
                },
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

