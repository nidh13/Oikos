import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/afterEstimation.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/properties_view.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class PropertiesDisplay extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;

  const PropertiesDisplay({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  _PropertiesDisplayState createState() => _PropertiesDisplayState();
}

class _PropertiesDisplayState extends State<PropertiesDisplay> {
  int selectedIndex;
  List<PropertiesModel>provedProperties=[];
  List<PropertiesModel>noProvedProperties=[];
  bool selected = false;

  @override
  void initState() {
    provedProperties = widget.listProp.where((i) => i.status == "Approved").toList();
    noProvedProperties = widget.listProp.where((i) => i.status == "Pending").toList();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    User user=widget.user;
    String token =widget.token;
    List<PropertiesModel>listProp=widget.listProp;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(index: 3,token: token,user: user,listProp: listProp,),
      body: Column(
        children: [
          CustomAppBar(
            title: "MES BIENS",
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    CustomButton(
                      text: "+ AJOUTER UN BIEN",
                      fontWeight:FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.7,
                      height: 48,
                      onPressed: (){
                        dispatchGoTOAddPropertiesEvent(token);
                      },
                    ),
                    (noProvedProperties.length == 0)? Container():Padding(
                      padding: const EdgeInsets.only(left: 20,bottom: 10,top: 40),
                      child: CustomText(
                        value: "En attente d'approbation",
                        color: ColorConstant.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    (noProvedProperties.length == 0)?Container():Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: (noProvedProperties.length ==1)?190 :360,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PropertiesView(propertiesModel: noProvedProperties[index],token: token,);
                          },
                          itemCount: noProvedProperties.length,
                        ),
                      ),
                    ),
                    (provedProperties.length == 0)?Container():Padding(
                      padding: const EdgeInsets.only(left: 20,bottom: 10,top: 40),
                      child: CustomText(
                        value: "Approuvés et Actifs",
                        color: ColorConstant.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    (provedProperties.length == 0)?Container():Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 360,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if(provedProperties[index].fileBien.isNotEmpty && provedProperties[index].fileBien != null){
                             var id = provedProperties[index].fileBien[0].id;
                             return myPropertiesView(token,provedProperties[index],id);
                            }
                            return myPropertiesView(token,provedProperties[index],null);
                          },
                          itemCount: provedProperties.length,
                        ),
                      ),
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }
  void dispatchGoTOAddPropertiesEvent(String token) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoTOAddPropertiesEvent(token: token));
  }
  Widget myPropertiesView(String token,PropertiesModel propertiesModel,String id){
   return InkWell(
      onTap: (){
        setState(() {
          selected = !selected;
        });
      },
      child: Card(
        color: ColorConstant.white,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
                height: 160,
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
                )
            ),
            selected?SizedBox(height: 20,):Container(),
            selected ?Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      dispatchGoToPropertieDisplay(propertiesModel,widget.listProp);
                    },
                    child: SvgPicture.asset("Assets/Images/eye.svg",),
                  ),
                  TextButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset('Assets/Images/published.svg',height: 24,width: 24,),
                      label: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: CustomText(
                          value: "ASSISTANT DE CREATION D'ANNONCES",
                          color: ColorConstant.blue,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  InkWell(
                    onTap: (){
                      dispatGoTOUpdatePropertiesDisplayEvent(propertiesModel);
                    },
                    child: SvgPicture.asset("Assets/Images/editIcon.svg",color: ColorConstant.primaryColor,height: 24,width: 24,),
                  )
                ],
              ),
            ):Container(),
            selected?SizedBox(height: 20,):Container(),
          ],
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
  void dispatchGoToPropertieDisplay(PropertiesModel propertiesModel,List<PropertiesModel>listProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToPropertieDisplay(propertiesModel: propertiesModel,listProp: listProp,token: widget.token));
  }
  void dispatchGoToFirstPageEvent(String token) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToFirstPageEvent(token: token));
  }
  void dispatGoTOUpdatePropertiesDisplayEvent(PropertiesModel propertiesModel) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoTOUpdatePropertiesDisplayEvent(propertiesModel: propertiesModel));
  }
}
