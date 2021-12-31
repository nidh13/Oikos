import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomCounter extends StatelessWidget {
  final String text ;
  final int value ;
  final Function add;
  final Function sub;


  CustomCounter({this.text, this.value, this.add, this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            value: text,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: ColorConstant.darkText,
          ),
          SizedBox(width: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: SvgPicture.asset("Assets/Images/Button-.svg"),
                  onPressed: sub
              ),
              CustomText(
                color: ColorConstant.dark,
                fontSize:14 ,
                value: value.toString(),
              ),
              IconButton(
                  icon: SvgPicture.asset("Assets/Images/Button+.svg"),
                  onPressed: add
              ),
            ],
          )
        ],
      ),
    );
  }
}
