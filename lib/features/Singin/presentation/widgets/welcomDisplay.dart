import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBackground.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/socialMediaWidget.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/bloc.dart';

class WelcomeDisplay extends StatefulWidget {
  @override
  _WelcomeDisplayState createState() => _WelcomeDisplayState();
}

class _WelcomeDisplayState extends State<WelcomeDisplay> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return Scaffold(
      body: CustomBackground(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:(MediaQuery.of(context).size.height /2)-150*screenHeight,),
                    SvgPicture.asset(
                      "Assets/Images/assets_icons_oikosim.svg",
                      height: 133*screenHeight,
                      width: 227*screenWidth,
                    ),
                    SizedBox(height:60*screenHeight,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          height: 50.0*screenHeight,
                          minWidth: 92*screenWidth,
                          child: TextButton(
                            onPressed: (){
                              dispatchGoToSigninEvent();
                            },
                            child: CustomText(
                              value:"SE CONNECTER",
                              color: ColorConstant.white,
                              fontSize: 11*screenWidth,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7*screenWidth,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 25*screenWidth,),
                        CustomButton(
                          height:50*screenHeight,
                          minWidth: 160*screenWidth,
                          text:"CRÉER UN COMPTE",
                          onPressed: (){
                            dispatchGoToSignupEvent();
                          },
                          fontSize: 11*screenWidth,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.7*screenWidth,
                        ),
                      ],
                    ),
                    SizedBox(height:60*screenHeight,),
                    SocialMediaWidget(
                      onPressedFacebook: (){},
                      onPressedGoogle: (){},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom:10),
              child: Center(
                child: InkWell(
                    onTap: (){
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(value:"Conditions d'utilisations",
                          textAlign: TextAlign.center,
                          color: ColorConstant.white,
                          fontSize:  10*screenWidth,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5*screenWidth,
                        ),
                        SizedBox(
                          width:8*screenWidth,
                        ),
                        SvgPicture.asset(
                          "Assets/Images/Ellipse 99.svg",
                        ),
                        SizedBox(
                          width:8*screenWidth,
                        ),
                        CustomText(value:"Oikos © 2021",
                          textAlign: TextAlign.center,
                          color: ColorConstant.white,
                          fontSize:  10*screenWidth,
                          fontWeight: FontWeight.w700,
                          letterSpacing:  0.5*screenWidth,
                        ),
                      ],
                    )
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
  void dispatchGoToSigninEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<LoginBloc>(context)
        .add(GoToSigninEvent());
  }
  void dispatchGoToSignupEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<LoginBloc>(context)
        .add(GoToSignupEvent());
  }
}
