import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Notification/domain/entities/notifications_model.dart';
import 'package:oikosmobile/features/Notification/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class NotificationDisplay extends StatefulWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;
  final Notifications notifications;

  const NotificationDisplay({Key key, this.user, this.token, this.listProp,this.notifications}) : super(key: key);
  @override
  _NotificationDisplayState createState() => _NotificationDisplayState();
}

class _NotificationDisplayState extends State<NotificationDisplay> {

  @override
  Widget build(BuildContext context) {
    User user=widget.user;
    String token=widget.token;
    List<PropertiesModel>listProp=widget.listProp;
    Notifications notifications = widget.notifications;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Notifications",
          ),
          SizedBox(
            height: 10,
          ),
          notifications.content.isEmpty?CustomText(
            value: "Vous N'avez aucun message",
            color: ColorConstant.googleLabel,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            //     height: 1.28,
          ):Container(),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: notifications.content.length,
                physics: ScrollPhysics(),
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,),
                          child: CustomText(
                            value: "02-12-2021",
                            color: ColorConstant.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            final getNotificationByIdParams = GetNotificationByIdParams(token: token,id:notifications.content[index].id );
                            dispatchGoToFirstPageEvent(getNotificationByIdParams);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 10,
                            ),
                            height: 65,
                            padding: EdgeInsets.symmetric(horizontal: 5),
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
                                Expanded(
                                  child: CustomText(
                                    value: notifications.content[index].content,
                                    color: ColorConstant.grayNotification,
                                    fontSize: 10,
                                    height: 1.25,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 3,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomText(
                                      value: etatToString(notifications.content[index].etat),
                                      color: ColorConstant.grayNotification,
                                      fontSize: 12,
                                      height: 1.25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    SizedBox(width: 5,),
                                    SvgPicture.asset('Assets/Images/notif.svg',color: Color(0xFF7E7E7E),height: 24,width: 20,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(index: 1,token: token,user: user,listProp: listProp,),
    );
  }
  String etatToString(String etat){
    switch(etat){
      case "NON_VU": return "non lus.";
      break ;
      case "VU": return "lus.";
      break ;
    }
  }
  void dispatchGoToFirstPageEvent(GetNotificationByIdParams getNotificationByIdParams) {
    BlocProvider.of<NotificationBloc>(context).add(ReadEvent(getNotificationByIdParams: getNotificationByIdParams));
  }
}
