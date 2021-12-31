import 'package:flutter/material.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomBar extends StatelessWidget {
  final String firstLine;
  final String secondLine;


  CustomBar({this.firstLine, this.secondLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
            height: 2,
            thickness: 2,
            color: ColorConstant.driver
        ),
        Container(
          padding:const EdgeInsets.only(top: 10,bottom: 10) ,
          decoration: BoxDecoration(
            gradient: LinearGradient(

                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[ ColorConstant.gradientAppBar,ColorConstant.gradientAppBar1,ColorConstant.blue,],
                stops: [0.0,0.5,1]
            ),
            //  shape: BoxShape.circle,
          ),
          child: Column(
            children: [
              CustomText(
                value: firstLine,
                color: ColorConstant.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon :Icon(Icons.location_on_outlined, color: ColorConstant.white),iconSize: 15,),
                  CustomText(
                    value: secondLine,
                    color: ColorConstant.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
