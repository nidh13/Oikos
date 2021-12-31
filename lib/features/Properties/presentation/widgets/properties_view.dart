import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';

class PropertiesView extends StatelessWidget {
  final String token ;
  final PropertiesModel propertiesModel;
  PropertiesView({
    this.propertiesModel,
    this.token
});

  @override
  Widget build(BuildContext context) {
    String id;
    if(propertiesModel.fileBien.isNotEmpty && propertiesModel.fileBien != null){
      id = propertiesModel.fileBien[0].id;
    }
    return Container(
      height: 160,
      child: Card(
        color: ColorConstant.white,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(10),

        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 20,right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network("http://197.13.15.233:8787/api/v1/properties/mediatype-image/$id",
                      fit: BoxFit.cover,
                      key: ValueKey(new Random().nextInt(100)),
                      headers: {
                        "authorization": "Bearer $token",
                        // Other headers if wanted
                      },
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null ?
                              loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "Assets/Images/backgroundImage.png",

                            fit: BoxFit.cover,

                          ),
                        );
                      },
                    ),

                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        value: "Vigneux 42140",
                        color: ColorConstant.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      CustomText(
                        value: propertiesModel.nbRooms.toString()+"pièces"+" - "+propertiesModel.homeArea.round().toString()+"m²",
                        color: ColorConstant.gray2Text,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      RobotoText(
                        value: propertiesModel.price.round().toString()+"€",
                        color: ColorConstant.grayText,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("Assets/Images/calendar.svg",),
                          SizedBox(width: 5,),
                          RobotoText(
                            value: getDate(propertiesModel.createdAt),
                            color: ColorConstant.blueText,
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("Assets/Images/clock.svg",),
                          SizedBox(width: 5,),
                          RobotoText(
                            value: getTime(propertiesModel.createdAt),
                            color: ColorConstant.blueText,
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  String getDate(String date){
    var year ;
    var day;
    var month;
    year = date.substring(0,4);
    day= date.substring(5,7);
    month =date.substring(8,10);
    return day+"/"+month+"/"+year;
  }
  String getTime(String date){
    var time;
    time = date.substring(11,16);

    return time;
  }

}
