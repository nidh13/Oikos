import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import 'colorsConstant.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int index ;
  bool fromLogout;
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
   CustomBottomNavBar({
    Key key,this.index,this.token,this.user,this.fromLogout,this.listProp
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 4,
      type: BottomNavigationBarType.fixed,
      backgroundColor:  ColorConstant.blue,
      selectedItemColor: ColorConstant.white,
      unselectedItemColor: Color(0xff999999),
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(

          icon: index == 0 ? SvgPicture.asset("Assets/Images/activeDashoard.svg"): SvgPicture.asset("Assets/Images/dashboard.svg"),
          title: Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: index == 1 ? SvgPicture.asset("Assets/Images/activeNotifi.svg"): SvgPicture.asset("Assets/Images/notif.svg"),
          title: Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: index == 2 ? SvgPicture.asset("Assets/Images/activeEnvelope.svg"): SvgPicture.asset("Assets/Images/envelop.svg",),
          title: Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: index == 3 ?SvgPicture.asset("Assets/Images/activeBien.svg" ,): SvgPicture.asset("Assets/Images/biens.svg" ,),
          title: Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: index == 4 ? SvgPicture.asset("Assets/Images/user.svg"): SvgPicture.asset("Assets/Images/inactiveUser.svg",),
          title: Container(height: 0.0),
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: true,
      onTap: (value) {
        if (value == 0)
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/homeProvider',
                arguments: {
                  'user':user,
                  'token':token,
                  'listProp':listProp,
                  'fromAppBar':true,
                }
            );
          });
        else if (value == 1)
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/NotificationProvider',
                arguments: {
                  'user':user,
                  'token':token,
                  'fromAppBar':true,
                  'listProp':listProp,
                }
            );
          });
        else if (value == 2)
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/MessageProvider',
                arguments: {
                  'user':user,
                  'token':token,
                  'sendMessage':false,
                  'listProp':listProp,
                }
            );
          });
        else if (value == 3)
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/BienProvider',
                arguments: {
                  'user':user,
                  'token':token,
                  'fromAppBar':true,
                  'listProp':listProp,
                }
            );
          });
        else if (value == 4) WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(
            '/ProfileProvider',
              arguments: {
                'user':user,
                'token':token,
                'fromAppBar':true,
                'listProp':listProp,
              }
          );
        });
      },
    );
  }
}
