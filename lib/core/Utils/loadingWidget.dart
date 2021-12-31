import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            ColorConstant.primaryColor,
          ),
        ),
      ),
    );
  }
}
