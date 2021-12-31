import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

import 'colorsConstant.dart';

class HelpWidget extends StatelessWidget {
  final String text ;
  HelpWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.only(left: 10,right: 5,top: 10,bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(5.0),),
          color: ColorConstant.helpBarColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SvgPicture.asset("Assets/Images/i.svg",height: 24,width: 24,),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CustomText(
                  fontSize: 13,
                  color: ColorConstant.darkTextInfo,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.clip,
                  value: text,
                  maxLines: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
