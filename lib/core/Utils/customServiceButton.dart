import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

class CustomServiceButton extends StatelessWidget {
  final Function onPressed;
  final String svgIcon;
  final String text;
  final bool isPaid;

  const CustomServiceButton({Key key, this.onPressed, this.svgIcon, this.text,this.isPaid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            height: 115,
            width: 115,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isPaid?ColorConstant.primaryColor.withOpacity(0.3):ColorConstant.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Color.fromRGBO(0, 0, 0, 0.09),
                    offset: Offset(0, 2),
                  )
                ]),
            child: Center(
              child: SvgPicture.asset(
                svgIcon,
                height: 43,
                width: 43,
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CustomText(
          value: text,
          color: ColorConstant.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.5,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
