import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBackground.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Home/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class HomeDisplayFirstConnexion extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  const HomeDisplayFirstConnexion({Key key, this.user,this.token,this.listProp}) : super(key: key);
  @override
  _HomeDisplayFirstConnexionState createState() => _HomeDisplayFirstConnexionState();
}

class _HomeDisplayFirstConnexionState extends State<HomeDisplayFirstConnexion> {
  File userImage;
  bool popUp = false;
  @override
  void initState() {
    imageCache.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    User user = widget.user;
    String token = widget.token;
    return Stack(
      children: [
        Scaffold(
/*
      bottomNavigationBar: CustomBottomNavBar(index: 0,),
*/
          body: CustomBackground(
            child: Column(
              children: [
                ClipPath(
                  clipper: CustomShape(), // this is my own class which extendsCustomClipper
                  child:Container(
                    height: 290,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: <Color>[ ColorConstant.gradient3,ColorConstant.blue,],
                      ),
                      //  shape: BoxShape.circle,
                    ),
                    //     padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.15, 0),
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
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: IconButton(
                              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                              onPressed: (){

                              },
                            ),
                          ),
                          actions: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: IconButton(
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: ColorConstant.white,
                                ),
                                onPressed: () {
                                  // do something
                                },
                              ),
                            )
                          ],
                        ),
                        Divider(
                            color: Colors.white
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 10),
                                    child: ClipOval(
                                      child:Image.network("http://197.13.15.233:8787/api/v1/user/me/picture",
                                        fit: BoxFit.cover,
                                        width: 88,
                                        height: 88,
                                        key: ValueKey(new Random().nextInt(100)),
                                        headers: {
                                          "authorization": "Bearer $token",
                                          // Other headers if wanted
                                        },
                                        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return ClipOval(
                                            child: Container(
                                              width: 88,
                                              height: 88,
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
                                            width: 88,
                                            height: 88,
                                            fit: BoxFit.cover,

                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          popUp =true;
                                        });
                                      },
                                      child: Container(
                                        height: 41,
                                        width: 41,
                                        decoration: new BoxDecoration(
                                          color: Color(0xFFC9DFEC),
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: SvgPicture.asset(
                                            "Assets/Images/Change Picture.svg",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  CustomText(
                                    value: user.firstName+" "+user.lastName,
                                    letterSpacing: 0.5,
                                    color: ColorConstant.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    //     height: 1.28,
                                  ),
                                  CustomText(
                                    value: user.departmentNumber+ ", France",
                                    letterSpacing: 0.5,
                                    color: ColorConstant.white,
                                    fontSize: 15,
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
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomText(
                    fontSize: 18,
                    color: ColorConstant.white,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    value: "Découvrez avec OIKOS la valeur de mon bien afin de préparer au mieux mon futur projet immobilier",
                    maxLines: 5,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    dispatchGoTOAddBienEvent();
                  },
                  child: Container(
                    height: 130,
                    width: screenWidth-100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(const Radius.circular(30.0),),
                      color: ColorConstant.primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          "Assets/Images/estimerLogo.svg",
                          width: 66,
                          height: 66,
                          fit: BoxFit.cover,
                        ),
                        CustomText(
                          fontSize: 14,
                          color: ColorConstant.white,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                          value: "ESTIMER MON BIEN",
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
                 dispatchGoToPickImageEvent();
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
                        value: "Sélectionner une photo de profil",
                      ),
                    ],
                  ),

                ),
              ),
            )
          ],
        ):Container()

      ],
    );
  }
  void dispatchGoTOAddBienEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<HomeBloc>(context)
        .add(GoTOAddBienEvent());
  }
  void dispatchGoToPickImageEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<HomeBloc>(context)
        .add(GoToImagePickEvent());
  }
}
class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

}

