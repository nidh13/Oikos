import 'package:flutter/material.dart';

import 'colorsConstant.dart';
import 'customText.dart';
class CustomImput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final String initialValue;
  final IconButton suffixIcon;
  final Function onChanged;


  CustomImput({this.labelText,this.hintText,this.textInputType,this.obscureText,this.initialValue,this.suffixIcon,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          color: ColorConstant.white,
          value: labelText,
          fontWeight: FontWeight.w400,
          fontSize:  12,
        ),
        SizedBox(height: 2,),
        Container(
          height: 48,
          width: 307,
          child: TextFormField(
            onChanged: onChanged,
            keyboardType: textInputType,
            style: TextStyle(
              fontFamily: 'Multi',
              fontWeight: FontWeight.w400,
              fontSize: 14 ,
              color: ColorConstant.dark ,
            ),
            obscureText: obscureText!= null?obscureText:false,
            initialValue: initialValue,
            decoration: InputDecoration(
              fillColor: ColorConstant.white,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: 'Multi',
                fontWeight: FontWeight.w400,
                fontSize: 11 ,
                color: ColorConstant.grayText ,
              ),
              contentPadding: const EdgeInsets.only(left: 20.0),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              border: InputBorder.none,
              suffixIcon:suffixIcon
            ),

          ),
        )
      ],
    );
  }
}
