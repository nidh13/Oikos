import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'colorsConstant.dart';
import 'customText.dart';

class CustomInputBien extends StatelessWidget {
  final String text;
  final String hint;
  final Widget suffixIcon;
  final BoxConstraints suffixIconConstraints;
  final Function onChanged;
  final TextInputType textInputType;
  final String initialValue;

  CustomInputBien({this.text, this.hint, this.suffixIcon,
      this.suffixIconConstraints, this.onChanged,this.textInputType,this.initialValue});

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
        SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: TextFormField(
              initialValue: initialValue,
              onChanged: onChanged,
               keyboardType: textInputType,
              style: TextStyle(
                fontFamily: 'Multi',
                fontWeight: FontWeight.w400,
                fontSize: 13 ,
                color: ColorConstant.dark ,
                  decoration: TextDecoration.none
              ),

              //   initialValue: initialValue,
              decoration: InputDecoration(
                fillColor: Color(0xFFF7F7F7),
                filled: true,
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: 'Multi',
                  fontWeight: FontWeight.w400,
                  fontSize: 13 ,
                  color: Color(0xFF959595) ,
                ),
                contentPadding: const EdgeInsets.only(left: 20.0,top:12,bottom:12 ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFEEEEEE) ,

                  ),
                  borderRadius: BorderRadius.all(const Radius.circular(10.0),),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color(0xFFEEEEEE)
                  ),
                  borderRadius: BorderRadius.all(const Radius.circular(10.0),),
                ),
                border: InputBorder.none,
                suffixIcon:suffixIcon,
                suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
              ),

            ),
          ),
        )
      ],
    );
  }
}


