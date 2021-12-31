import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'colorsConstant.dart';

class AddImageCard extends StatelessWidget {
  final Function onTap ;
  final double height;
  final double width;


  AddImageCard({this.onTap,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: FDottedLine(
              color: ColorConstant.primaryColor,
              strokeWidth: 2.0,
              dottedLength: 10.0,
              space: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset("Assets/Images/Groupe 3268.svg"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              child: SvgPicture.asset("Assets/Images/Groupe 9591.svg",width: 30,height: 30,),
              onTap: onTap,
            ),
          )
        ],
      ),
    );
  }
}