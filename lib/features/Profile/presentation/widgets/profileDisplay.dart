import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Home/presentation/widgets/homeDisplayFirstConnexion.dart';
import 'package:oikosmobile/features/Profile/presentation/bloc/profile_bloc.dart';
import 'package:oikosmobile/features/Profile/presentation/bloc/profile_event.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/myproperties_view.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/properties_view.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class ProfileDisplay extends StatefulWidget {
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;

  const ProfileDisplay({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  _ProfileDisplayState createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  bool popUp = false;
  @override
  void initState() {
    imageCache.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     User user=widget.user;
     String token =widget.token;
     List<PropertiesModel>listProp=widget.listProp;
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: CustomBottomNavBar(index: 4,token: token,user: user,listProp: listProp,),
          body: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                      clipper: CustomShape(), // this is my own class which extendsCustomClipper
                      child:Stack(
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("Assets/Images/backgroundImageCroped.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: <Color>[ ColorConstant.gradientProfil1,ColorConstant.gradientProfil2,],
                                  tileMode: TileMode.clamp
                              ),
                              //  shape: BoxShape.circle,
                            ), //     padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.15, 0),
                          ),
                          Container(
                            height: 250,
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                  centerTitle: true,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: CustomText(
                                      value: "MON COMPTE",
                                      letterSpacing: 0.5,
                                      color: ColorConstant.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      height: 1.28,
                                    ),
                                  ),
                                  leading: Container(),
                                  actions: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.settings_outlined,
                                          color: ColorConstant.white,
                                        ),
                                        onPressed: () {
                                          dispatchGoToUpdateProfileEvent();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                    color: Colors.white
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            popUp = true;
                                          });
                                        },
                                        child: ClipOval(
                                          child:Image.network("http://197.13.15.233:8787/api/v1/user/me/picture",
                                            fit: BoxFit.cover,
                                            width: 56,
                                            height: 56,
                                            key: ValueKey(new Random().nextInt(100)),
                                            headers: {
                                              "authorization": "Bearer $token",
                                              // Other headers if wanted
                                            },
                                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return ClipOval(
                                                child: Container(
                                                  width: 56,
                                                  height: 56,
                                                  child: Center(
                                                    child: CircularProgressIndicator(
                                                      value: loadingProgress.expectedTotalBytes != null ?
                                                      loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                              return SvgPicture.asset(
                                                "Assets/Images/avatar.svg",
                                                width: 56,
                                                height: 56,
                                                fit: BoxFit.cover,

                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          CustomText(
                                            value: user.firstName+" "+user.lastName,
                                            letterSpacing: 0.5,
                                            color: ColorConstant.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            //     height: 1.28,
                                          ),
                                          CustomText(
                                            value: user.departmentNumber+ ", France",
                                            letterSpacing: 0.5,
                                            color: ColorConstant.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            //     height: 1.28,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  Container(
                    height: 240,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Container(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                fontFamily: 'Multi',
                                fontWeight: FontWeight.w400,
                                fontSize: 14 ,
                                color: ColorConstant.searchText,
                              ),
                              hintText: "Recherche ",
                              fillColor: ColorConstant.white,
                              prefixIcon: Icon(Icons.search,color: ColorConstant.searchIcon,),
                              contentPadding: const EdgeInsets.only(left: 10.0,top:5,bottom:5 ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFEEEEEE) ,
                                ),
                                borderRadius: BorderRadius.all(const Radius.circular(20.0),),
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFFEEEEEE)
                                ),
                                borderRadius: BorderRadius.all(const Radius.circular(20.0),),
                              ),
                            ),

                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                value: "Mes Biens",
                                color: ColorConstant.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                              InkWell(
                                onTap: (){
                                  print("voir tous");
                                },
                                child: CustomText(
                                  value: "Voir tous",
                                  color: ColorConstant.grayText,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        PropertiesView(propertiesModel: listProp[listProp.length-1],token: token,),
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                value: "Statistiques & Historiques",
                                color: ColorConstant.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                              InkWell(
                                onTap: (){
                                  print("voir tous");
                                },
                                child: CustomText(
                                  value: "Voir tous",
                                  color: ColorConstant.grayText,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          height: 197,
                          child:Card(
                            color: ColorConstant.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                              borderRadius:BorderRadius.circular(10),

                            ),
                            child: Container(
                              // padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: CustomText(
                                      value: "Nbre total des visites d'annonce",
                                      color: ColorConstant.grayText7,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: 3,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: RobotoText(
                                      value: "Aujourd'hui",
                                      color: ColorConstant.grayText,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset('Assets/Images/UpIcon.svg'),
                                                RobotoText(
                                                  value: "+ 3.49%",
                                                  color: ColorConstant.greenStat,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            RobotoText(
                                              value: "178,080",
                                              color: ColorConstant.blackStat,
                                              fontSize: 31,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 15),
                                          child: SvgPicture.asset('Assets/Images/greenGraph.svg'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        popUp? Stack(
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  popUp = false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color:  ColorConstant.blueLoading,
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: (){
                  dispatchGoToImagePickerEvent(false);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 140,
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset("Assets/Images/popUpImage.svg",),
                      CustomText(
                        fontSize: 14,
                        color: ColorConstant.primaryColor,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w700,
                        value: "   Changer la photo de profil   ",
                      ),
                    ],
                  ),

                ),
              ),
            )
          ],
        ):Container(),
      ],
    );
  }
  void dispatchGoToImagePickerEvent(bool firstConexion) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ProfileBloc>(context)
        .add(GoToImagePickerEvent(firstConexion: firstConexion));
  }
  void dispatchGoToUpdateProfileEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ProfileBloc>(context)
        .add(GoToUpdateProfileEvent());
  }

}
