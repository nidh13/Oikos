import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

class CustomThreeRadioBar extends StatelessWidget {
  final int groupValue;
  final Function firstChoice;
  final Function secondChoice;
  final Function thirdChoice;
  final String text;
  final String firstChoiceText;
  final String secondChoiceText;
  final String thirdChoiceText;


  CustomThreeRadioBar({this.groupValue, this.firstChoice, this.secondChoice,
      this.text,this.thirdChoice,this.firstChoiceText,this.secondChoiceText,this.thirdChoiceText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CustomText(
            value: text,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: ColorConstant.darkText,
          ),
        ),
        SizedBox(height: 2,),
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: 1,
                      groupValue: groupValue,
                      activeColor: ColorConstant.primaryColor,
                      onChanged: firstChoice
                  ),
                  CustomText(
                    value: firstChoiceText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.gray,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 2,
                    groupValue: groupValue,
                    activeColor: ColorConstant.primaryColor,
                    onChanged: secondChoice,
                  ),
                  CustomText(
                    value: secondChoiceText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.gray,
                  )
                ],
              ),
              Row(
                children: [
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 3,
                    groupValue: groupValue,
                    activeColor: ColorConstant.primaryColor,
                    onChanged: thirdChoice,
                  ),
                  CustomText(
                    value: thirdChoiceText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.gray,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
