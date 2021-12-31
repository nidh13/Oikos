import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Message/domain/entities/chatMessage.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThreds.dart';
import 'package:oikosmobile/features/Message/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class ChatDisplay extends StatefulWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;
  final MessageThreads messageThreads;

  const ChatDisplay({Key key, this.user, this.token, this.listProp,this.messageThreads}) : super(key: key);
  @override
  _ChatDisplayState createState() => _ChatDisplayState();
}

class _ChatDisplayState extends State<ChatDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user=widget.user;
    String token=widget.token;
    List<PropertiesModel>listProp=widget.listProp;
    MessageThreads messageThreads = widget.messageThreads;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(index: 2,token: token,user: user,listProp: listProp,),
      body: Column(
        children: [
          CustomAppBar(
            title: "Messages",
          ),
          SizedBox(height: 10,),
          messageThreads.content.isEmpty?CustomText(
            value: "Vous N'avez aucun message",
            color: ColorConstant.googleLabel,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            //     height: 1.28,
          ):Container(),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
              itemCount: messageThreads.content.length,
                itemBuilder: (context,index)=>MessageCard(index,messageThreads)
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: ColorConstant.primaryColor,
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
  Widget MessageCard(int index,MessageThreads messageThreads){
    var token = widget.token;
    var user =widget.user;
    var userId = messageThreads.content[index].recipientID;
    var date = convertIso(messageThreads.content[index].dateLastMessage);
    return InkWell(
      onTap: (){
        dispatchMessageDisplayEvent( messageThreads.users[index], messageThreads.listMessageThread[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child:Image.network("http://197.13.15.233:8787/api/v1/user/$userId/picture",
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    key: ValueKey(new Random().nextInt(100)),
                    headers: {
                      "authorization": "Bearer $token",
                      // Other headers if wanted
                    },
                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ClipOval(
                        child: Container(
                          width: 60,
                          height: 60,
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
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,

                      );
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3
                      )
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      value: messageThreads.users[index].firstName+" "+messageThreads.users[index].lastName,
                      color: ColorConstant.googleLabel,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      //     height: 1.28,
                    ),
                    CustomText(
                      value: messageThreads.listMessageThread[index].content.first.content,
                      color: ColorConstant.grayText,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      //     height: 1.28,
                    )
                  ],
                ),
              ),
            ),
            RobotoText(
              value: date.hour.toString()+":"+date.minute.toString()+" PM",
              color: ColorConstant.grayText,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              //     height: 1.28,
            )
          ],
        ),
      ),
    );
  }
  void dispatchMessageDisplayEvent(User sender,MessageThread thread) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<MessageBloc>(context)
        .add(GoToMessageDisplayEvent(sender: sender,messageThread:thread ));
  }
  DateTime convertIso(String date){
    return DateTime.parse(date);
  }
  bool isRead (String status){
    if(status =="SENT "){
      return true;
    }
    return false;
  }
}
