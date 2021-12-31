import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/Images/backgroundImageCroped.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    ColorConstant.primaryColor.withOpacity(0),
                    ColorConstant.gradient1.withOpacity(0.81),
                    ColorConstant.gradient2,
                  ],
                  stops: [0.05, 0.6, 1],
                    tileMode: TileMode.clamp
                )
            ),
          ),
          child,
        ]
    );
  }
}
