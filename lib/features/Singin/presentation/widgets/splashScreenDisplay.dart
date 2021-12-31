import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/customBackground.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/bloc.dart';

class SplashScreenDisplay extends StatefulWidget {
  @override
  _SplashScreenDisplayState createState() => _SplashScreenDisplayState();
}

class _SplashScreenDisplayState extends State<SplashScreenDisplay> {
  final splashDelay = 5;

  @override
  void initState() {
    super.initState();
    _loaddata();
  }
  _loaddata()async{
    var _duration = Duration(seconds: splashDelay);
    Timer(_duration, () {
      BlocProvider.of<LoginBloc>(context).add(GotoWelcomEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    return Scaffold(
      body: CustomBackground(
        child: Center(
            child: SvgPicture.asset(
              "Assets/Images/assets_icons_oikosim.svg",
              height: 161.23,
              width: 230.92,
            )
        ),
      ),
    );
  }
}
