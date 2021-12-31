import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

import 'colorsConstant.dart';

class HelpCalendarWidget extends StatelessWidget {
  final String text ;
  const HelpCalendarWidget({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 10,right: 5,top: 10,bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(5.0),),
          color: ColorConstant.helpBarColor,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SvgPicture.asset("Assets/Images/i.svg",height: 24,width: 24,),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomText(
                      fontSize: 13,
                      color: ColorConstant.darkTextInfo,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.clip,
                      value: text,
                      maxLines: 10,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 26,
                  width: 105,
                  child: ElevatedButton(
                    child: CustomText(
                      value:"Visite physique",
                      color: ColorConstant.white,
                      fontSize:10,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      primary: ColorConstant.maxEstimationColor,

                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                  width: 105,
                  child: ElevatedButton(
                    child: CustomText(
                      value:"Visite virtuelle",
                      color: ColorConstant.white,
                      fontSize:10,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      primary: ColorConstant.primaryColor,

                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                  width: 105,
                  child: ElevatedButton(
                    child: CustomText(
                      value:"Visite groupé",
                      color: ColorConstant.white,
                      fontSize:10,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      primary: ColorConstant.blue,

                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
