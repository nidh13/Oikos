import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

class TermPolicyWidget extends StatelessWidget {
  final String text;
  final Function onChanged;
  final bool value;
  TermPolicyWidget({this.text, this.onChanged,this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            onChanged:onChanged ,
            value: value,
            activeColor: ColorConstant.checkBox,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: CustomText(
                fontSize: 10,
                color: ColorConstant.blue,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.clip,
                value: text,
                maxLines: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
