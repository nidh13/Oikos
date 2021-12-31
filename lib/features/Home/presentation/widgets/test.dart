import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Home/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';



class HomePageTest extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  

  const HomePageTest({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  _MenuDashBoardState createState() => _MenuDashBoardState();
}

class _MenuDashBoardState extends State<HomePageTest> {

  bool isMenuClosed = true;
  bool logOut = false;
  double screenWidth;
  int selectedScreen = 0;
  GlobalKey greenIndicatorKey = GlobalKey();
  double top, left, width;
  ScrollController _scrollController = ScrollController();
  //UserProfile userProfile;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
   // userProfile = (Get.find<AuthController>().state as Authenticated).user;
  }

  _afterLayout(_) {
    setState(() {
      _getPosition();
    });
  }

  _getPosition() async {
    final RenderBox rb = greenIndicatorKey.currentContext.findRenderObject();
    var position = rb.localToGlobal(Offset.zero);
    top = position.dy;
    left = position.dx;
    width = rb.size.width;
    print('$left , $top');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    User user=widget.user;
    String token=widget.token;
    List<PropertiesModel>listProp=widget.listProp;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context),
            logOut?Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      logOut = false;
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        //  _loadPicker(ImageSource.gallery);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 270,
                        decoration: BoxDecoration(
                            color: ColorConstant.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.logout,
                                color: ColorConstant.primaryColor,
                                size: 50,
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: CustomText(
                                value: "Se déconnecter ?",
                                color: ColorConstant.dark,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    dispatchLogOutEvent();
                                    //  dispatchGoToCameraEvent(propertiesModel);
                                  },
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: CustomText(
                                        value: "D'ACCORD",
                                        color: ColorConstant.primaryColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.7,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  text: "NON, MERCI",
                                  fontWeight:FontWeight.w800,
                                  fontSize: 11,
                                  letterSpacing: 0.7,
                                  height: 48,
                                  onPressed: (){
                                   setState(() {
                                     logOut = false;
                                   });
                                  },
                                  minWidth: 135,
                                )
                              ],
                            )
                          ],
                        ),

                      ),
                    ),
                  ),
                )
              ],
            ):Container(),
          ],
        ),
      ),
      bottomNavigationBar: isMenuClosed
          ? CustomBottomNavBar(index: 0,token: token,user: user,listProp: listProp,)
          : null,
    );
  }

  Widget menu(context) {
    String token=widget.token;
    User user=widget.user;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[ColorConstant.gradientDrawer1, ColorConstant.gradientDrawer2],
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.15, 0),
      child: SingleChildScrollView(
        controller:_scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25, left: 36),
              height: 110,
              color: ColorConstant.gradientDrawer2,
              child: ListTile(
                leading: SizedBox(
                  height: 63,
                  width: 63,
                  child: CircleAvatar(
                    backgroundColor: ColorConstant.white,
                    child: ClipOval(
                      child: Image.network("http://197.13.15.233:8787/api/v1/user/me/picture",
                        fit: BoxFit.cover,
                        width: 63,
                        height: 63,
                        key: ValueKey(new Random().nextInt(100)),
                        headers: {
                          "authorization": "Bearer $token",
                          // Other headers if wanted
                        },
                        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return ClipOval(
                            child: Container(
                              width: 63,
                              height: 63,
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
                ),
                title: CustomText(
                  value: user.firstName+" "+user.lastName,
                  color: ColorConstant.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
                subtitle: CustomText(
                  value: user.departmentNumber+ ", France",
                  color: ColorConstant.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                )
              ),
            ),
/*            Container(
              margin: EdgeInsets.only(
                top: 25,
                left: 35,
              ),
              height: 45,
              width: 185,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Switch(
                    value: true,
                    onChanged: (v) {
                      print("mm");
                    },
                  ),
                  Text(
                    'Mode Propriétaire',
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),*/
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
                bottom: 0,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/dashbord.svg',height: 24,width: 24,),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "TABLEAU DE BORD",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/messageries.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:CustomText(
                      value: "MESSAGERIES",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/stats.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "STATISTIQUES & HISTORIQUES",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {
                    print("ok");
                  },
                  icon: SvgPicture.asset('Assets/Images/biensDrawer.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "MES BIENS",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {
                    print("ok");
                  },
                  icon: SvgPicture.asset('Assets/Images/services.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "SERVICES",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/visites.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "Comptes Rendus Visites".toUpperCase(),
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/calendar.svg',color: ColorConstant.white,height: 24,width: 24,),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "AGENDA",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/assistance.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "ASSISTANCE",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/recherche.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "RECHERCHE",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('Assets/Images/parametres.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                      value: "PARAMETRES",
                      letterSpacing: 0.5,
                      color: ColorConstant.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ),
            Container(
              width: 280,
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 140,
                bottom: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('Assets/Images/facebookDrawer.svg'),
                  SvgPicture.asset('Assets/Images/instagram.svg'),
                  SvgPicture.asset('Assets/Images/twitter.svg'),
                  CustomText(
                    value: "Oikos © 2021",
                    letterSpacing: 0.5,
                    color: ColorConstant.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      //top: isMenuClosed? 0 : 100,
      //bottom: isMenuClosed? 0 : 100,
      top: 0,
      bottom: 0,
      left: isMenuClosed ? 0 : 280,
      right: isMenuClosed ? 0 : -280,
      duration: Duration(milliseconds: 300),
      child: Material(
        elevation: 8,
        color: ColorConstant.white,
        child: Column(
          children: [
            builtHomeScreenAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only( top: 40),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 120,
                          child: Row(
                            children: [
                              SizedBox(width: 30,),
                              Container(
                                height: 115,
                                width: 115,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConstant.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        color: Color.fromRGBO(0, 0, 0, 0.09),
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'Assets/Images/biensDrawer.svg',
                                      height: 34,
                                      width: 34,
                                      color: ColorConstant.blue,
                                    ),
                                    CustomText(
                                      value: "MES BIENS",
                                      letterSpacing: 0.5,
                                      color: ColorConstant.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: (){
                                  dispatchGoToServiceEvent();
                                },
                                child: Container(
                                  height: 115,
                                  width: 115,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: ColorConstant.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 8,
                                          color: Color.fromRGBO(0, 0, 0, 0.09),
                                          offset: Offset(0, 2),
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        'Assets/Images/services.svg',
                                        height: 34,
                                        width: 34,
                                        color: ColorConstant.blue,
                                      ),
                                      CustomText(
                                        value: "SERVICES",
                                        letterSpacing: 0.5,
                                        color: ColorConstant.blue,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),

                              Container(
                                key: greenIndicatorKey,
                                height: 115,
                                width: 115,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConstant.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        color: Color.fromRGBO(0, 0, 0, 0.09),
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Stack(
                                      children: [
                                        SvgPicture.asset(
                                          'Assets/Images/messageries.svg',
                                          height: 34,
                                          width: 34,
                                          color: ColorConstant.blue,
                                        ),
                                        Positioned(
                                          child: Container(
                                            height: 11,
                                            width: 11,
                                            decoration: BoxDecoration(
                                              color: ColorConstant.redNotification,
                                              borderRadius:
                                              BorderRadius.circular(100),
                                            ),
                                          ),
                                          right: 0,
                                          top: 0,

                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      value: "Messageries".toUpperCase(),
                                      letterSpacing: 0.5,
                                      color: ColorConstant.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 115,
                                width: 115,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorConstant.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        color: Color.fromRGBO(0, 0, 0, 0.09),
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'Assets/Images/stats.svg',
                                      height: 34,
                                      width: 34,
                                      color: ColorConstant.blue,
                                    ),
                                    CustomText(
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      value: "Statistiques \n& historiques".toUpperCase(),
                                      color: ColorConstant.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 115,
                                width: 115,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorConstant.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        color: Color.fromRGBO(0, 0, 0, 0.09),
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'Assets/Images/assistance.svg',
                                      height: 34,
                                      width: 34,
                                      color: ColorConstant.blue,
                                    ),
                                    CustomText(
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      value: "Contacter\nAgent".toUpperCase(),
                                      color: ColorConstant.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25,
                        top: 35,
                      ),
                      child: Divider(
                        color: Color(0xffE8E8E8),
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 35,
                      ),
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 241, 241, 0.44),
                        border: Border.all(
                          color: Color(0xffE9E9E9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaleFactor: 1.0,
                            text: TextSpan(
                              text: 'Vous avez ',
                              style: TextStyle(
                                color: ColorConstant.grayNotification,
                                fontSize: 12,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Multi',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '2 nouveaux offres',
                                  style: TextStyle(
                                    color:ColorConstant.grayNotification,
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Multi',
                                  ),
                                ),
                                TextSpan(
                                  text: ' non lus.',
                                  style: TextStyle(
                                    color:ColorConstant.grayNotification,
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Multi',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SvgPicture.asset('Assets/Images/calendar.svg',color: Color(0xFF7E7E7E),height: 24,width: 20,)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                      ),
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 241, 241, 0.44),
                        border: Border.all(
                          color: Color(0xffE9E9E9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaleFactor: 1.0,
                            text: TextSpan(
                              text: 'Vous avez ',
                              style: TextStyle(
                                color:ColorConstant.grayNotification,
                                fontSize: 12,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Multi',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '1 bien en approbation.',
                                  style: TextStyle(
                                    color: ColorConstant.grayNotification,
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Multi',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset('Assets/Images/label.svg')
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                      ),
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 241, 241, 0.44),
                        border: Border.all(
                          color: Color(0xffE9E9E9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaleFactor: 1.0,
                            text: TextSpan(
                              text: 'Vous avez ',
                              style: TextStyle(
                                color:ColorConstant.grayNotification,
                                fontSize: 12,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Multi',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '3 CR de visites',
                                  style: TextStyle(
                                    color: ColorConstant.grayNotification,
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Multi',
                                  ),
                                ),
                                TextSpan(
                                  text: ' non lus.',
                                  style: TextStyle(
                                    color: ColorConstant.grayNotification,
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Multi',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SvgPicture.asset('Assets/Images/notebook.svg')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25,
                        top: 35,
                      ),
                      child: Divider(
                        color: Color(0xffE8E8E8),
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 30,
                        bottom: 25,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                value: 'Prochain RDV',
                                color: ColorConstant.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                              CustomText(
                                value: 'Nombre Totale d\'Offres Reçus',
                                color: ColorConstant.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RobotoText(
                                value: '25/2/2021 \n10:00 AM',
                                color: ColorConstant.whiteBlueText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                              RobotoText(
                                value: '51',
                                color: ColorConstant.whiteBlueText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                value: 'Nbre des CR des visites',
                                color: ColorConstant.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                              CustomText(
                                value: 'Montant de dernier offre',
                                color: ColorConstant.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RobotoText(
                                value: '15',
                                color: ColorConstant.whiteBlueText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                              RobotoText(
                                value: '178,080 €',
                                color: ColorConstant.whiteBlueText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25,
                        top: 30,
                        bottom: 35,
                      ),
                      child: Divider(
                        color: Color(0xffE8E8E8),
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25,
                        bottom: 20,
                      ),
                      child: Container(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25,
                        bottom: 35,
                      ),
                      child: Container(
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
                                    value: "Nbre des appels téléphoniques",
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
                                              SvgPicture.asset('Assets/Images/DownIcon.svg'),
                                              RobotoText(
                                                value: "- 0.42%",
                                                color: ColorConstant.orangeStat,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          RobotoText(
                                            value: "136,25",
                                            color: ColorConstant.blackStat,
                                            fontSize: 31,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2,
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset('Assets/Images/Graph.svg'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container builtHomeScreenAppBar() {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
      ),
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[ ColorConstant.gradientAppBar,ColorConstant.gradientAppBar1,ColorConstant.blue,],
            stops: [0.0,0.5,1]
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: isMenuClosed ? 10 : 15,
              bottom: isMenuClosed ? 0 : 0,
            ),
            child: IconButton(
              icon: Icon(
                isMenuClosed ? Icons.menu : Icons.close,
                color: ColorConstant.white,
              ),
              onPressed: () {
                setState(() {
                  isMenuClosed = !isMenuClosed;
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                });
              },
            ),
          ),
          if (isMenuClosed)
            CustomText(
              value: "TABLEAU DE BORD",
              color: ColorConstant.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          IconButton(
            onPressed: () {
              setState(() {
                logOut = true;
              });
            },
            icon: Icon(
              Icons.logout,
              color: ColorConstant.white,
              size: 24,
            ),
          )
        ],
      ),
    );
  }
  void dispatchLogOutEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<HomeBloc>(context)
        .add(LogOutEvent());
  }
  void dispatchGoToServiceEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<HomeBloc>(context)
        .add(GoToServiceEvent());
  }
}
