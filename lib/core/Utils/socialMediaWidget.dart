import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/OpenSansText.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class SocialMediaWidget extends StatelessWidget {
  final Function onPressedFacebook;
  final Function onPressedGoogle;

  SocialMediaWidget({this.onPressedFacebook, this.onPressedGoogle});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20*screenWidth,
              child: Divider(
                color: ColorConstant.white,
                thickness: 1.5,
              ),
            ),
            SizedBox(width: 20*screenWidth,),
            Container(
             width: 255*screenWidth,
            // height: 20,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CustomText(
                  value: "Ou se connecter par votre compte",
                  textAlign:TextAlign.center,
                  color: ColorConstant.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16*screenWidth,
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(width: 20*screenWidth,),
            Container(
              width: 20*screenWidth,
              child: Divider(
                color: ColorConstant.white,
                thickness: 1.5,
              ),
            ),
          ],
        ),
        SizedBox(height:15*screenHeight,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonTheme(
              height:  50*screenHeight,
              minWidth: 160*screenWidth,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: RaisedButton(
                color: ColorConstant.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "Assets/Images/Google.svg",
                      height: 20*screenHeight,
                      width: 20*screenWidth,
                    ),
                    SizedBox(width: 9*screenWidth,),
                    OpenSansText(
                      value:"Google",
                      color: ColorConstant.googleLabel,
                      fontSize:   14,
                      fontWeight: FontWeight.w400,
                      letterSpacing:  0.766,
                    )
                  ],
                ),
                onPressed:onPressedGoogle,
              ),
            ),
            SizedBox(width:15*screenWidth,),
            ButtonTheme(
              height:   50*screenHeight,
              minWidth: 160*screenWidth,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: RaisedButton(
                color: ColorConstant.blueFacebook,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "Assets/Images/facebook.svg",
                      height: 20*screenHeight,
                      width: 9.29*screenWidth,
                    ),
                    SizedBox(width: 20*screenWidth,),
                    OpenSansText(
                      value:"Facebook",
                      color: ColorConstant.white,
                      fontSize:  14*screenWidth,
                      fontWeight: FontWeight.w400,
                      letterSpacing:   0.766*screenWidth,
                    )
                  ],
                ),
                onPressed:onPressedFacebook,
              ),
            ),
          ],
        ),
      ],);
  }
}
