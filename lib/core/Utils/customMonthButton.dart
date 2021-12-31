import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

import 'colorsConstant.dart';

class CustomMonthButton extends StatelessWidget {
  final bool checked;
  final Function onTap;
  final String text;
  final bool available;

  const CustomMonthButton({Key key, this.checked, this.onTap, this.text,this.available}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 91,
            height: 35,
            decoration: BoxDecoration(
              border: checked?Border.all(
                  color: Color(0xff1EC501), width: 1):null,
              borderRadius: BorderRadius.circular(20.0),
              color: checked ? ColorConstant.white:available?ColorConstant.monthButtonIsChecked: ColorConstant.monthButton,
            ),
            child: Center(
              child: CustomText(
                value:text,
                color:checked ? ColorConstant.primaryColor:ColorConstant.white,
                fontSize:12,
                fontWeight: FontWeight.w600,

              ),
            ),
          ),
          if(checked)Positioned(
            right: -4,
            top: -8,
            child: Icon(
              Icons.check_circle,
              color: Color(0xff1EC501),
            ),
          )
        ],
      ),
    );
  }
}
