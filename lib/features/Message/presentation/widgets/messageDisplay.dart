
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Message/domain/entities/chatMessage.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/presentation/bloc/message_bloc.dart';
import 'package:oikosmobile/features/Message/presentation/bloc/message_event.dart';
import 'package:oikosmobile/features/Message/presentation/widgets/components/messageCard.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_client.dart';

class MessageDisplay extends StatefulWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;
  final MessageThread messageThread;
  final User sender;

  const MessageDisplay({Key key, this.user, this.token, this.listProp, this.messageThread, this.sender}) : super(key: key);
  @override
  _MessageDisplayState createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  http.Client client =http.Client();
  Timer timer;
  MessageThread messageThread;
  int length ;
  final myController = TextEditingController();
  @override
  void initState() {
    startTimer();
    messageThread=widget.messageThread;
    messageThread.content = new List.from(messageThread.content.reversed);
    messageThread.content.removeWhere((item) => item.content== 'test');
    length =messageThread.content.length;
    print(length);
    super.initState();
  }
  @override
  void dispose() {
   cancelTimer();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    User user=widget.user;
    String token=widget.token;
    List<PropertiesModel>listProp=widget.listProp;
     User sender=widget.sender;
    return Scaffold(
      body: Column(
        children: [
          buildAppBar(),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
              itemCount:messageThread.content.length,
              itemBuilder: (context, index) {
                var userId = sender.id;
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: isSender(messageThread.content[index])? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isSender(messageThread.content[index])) ...[
                        ClipOval(
                          child:Image.network("http://197.13.15.233:8787/api/v1/user/$userId/picture",
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                            key: ValueKey(new Random().nextInt(100)),
                            headers: {
                              "authorization": "Bearer $token",
                              // Other headers if wanted
                            },
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return ClipOval(
                                child: Container(
                                  width: 30,
                                  height: 30,
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
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,

                              );
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                        decoration: BoxDecoration(
                            color: ColorConstant.primaryColor.withOpacity(isSender(messageThread.content[index])?1:0.1),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: CustomText(
                          value: messageThread.content[index].content,
                          color: isSender(messageThread.content[index])?ColorConstant.white:ColorConstant.darkText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          //     height: 1.28,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          ),
         Padding(
           padding: const EdgeInsets.only(top: 5),
           child: chatInput(),
         ),
        ],
      ),
    );
  }
  Widget buildAppBar(){
    User user=widget.user;
    String token=widget.token;
    List<PropertiesModel>listProp=widget.listProp;
    String id =widget.sender.id;
    MessageThread messageThread=widget.messageThread;
    User sender=widget.sender;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[ ColorConstant.gradientAppBar,ColorConstant.gradientAppBar1,ColorConstant.blue,],
            stops: [0.0,0.5,1]
        ),
        //  shape: BoxShape.circle,
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: BackButton(color: ColorConstant.white,onPressed: (){
          dispatchGoToFirstPageEvent();
        },),
        title: Row(
          children: [
            ClipOval(
              child:Image.network("http://197.13.15.233:8787/api/v1/user/$id/picture",
                fit: BoxFit.cover,
                width: 40,
                height: 40,
                gaplessPlayback: true,
                key: ValueKey(new Random().nextInt(100)),
                headers: {
                  "authorization": "Bearer $token",
                  // Other headers if wanted
                },
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {

                  if (loadingProgress == null) return child;
                  return ClipOval(
                    child: Container(
                      width: 40,
                      height: 40,
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
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,

                  );
                },
              ),
            ),
            SizedBox(width: 10,),
            CustomText(
              value: sender.firstName +" "+sender.lastName,
              color: ColorConstant.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              //     height: 1.28,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.local_phone,color: ColorConstant.white,),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.videocam,color: ColorConstant.white,),
          ),
        ],
      ),
    );
  }
  Widget chatInput(){
    User user=widget.user;
    String token=widget.token;
    List<PropertiesModel>listProp=widget.listProp;
    String id =widget.sender.id;
    MessageThread messageThread=widget.messageThread;
    User sender=widget.sender;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20
      ),
      decoration: BoxDecoration(
          color: ColorConstant.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0,4),
                blurRadius: 32,
                color: Color(0xFF087949).withOpacity(0.08)
            )
          ]
      ),
      child: Row(
        children: [
          Icon(Icons.mic,color: ColorConstant.primaryColor,),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: ColorConstant.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt_outlined),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          hintText: "Taper un message",
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20,),
          InkWell(child: Icon(Icons.send,color: ColorConstant.primaryColor),onTap: (){sendMessage(sender.id, myController.text, token);},),
        ],

      ),
    );
  }
  Widget MessageCardWidget(int index){
    User user=widget.user;
    String token=widget.token;
    List<PropertiesModel>listProp=widget.listProp;
    MessageThread messageThread=widget.messageThread;
    User sender=widget.sender;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: isSender(messageThread.content[index])? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender(messageThread.content[index])) ...[
            ClipOval(
              child:Image.network("http://197.13.15.233:8787/api/v1/user/me/picture",
                fit: BoxFit.cover,
                width: 35,
                height: 35,
                key: ValueKey(new Random().nextInt(100)),
                headers: {
                  "authorization": "Bearer $token",
                  // Other headers if wanted
                },
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return ClipOval(
                    child: Container(
                      width: 30,
                      height: 30,
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
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,

                  );
                },
              ),
            ),
            SizedBox(width: 20),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
            decoration: BoxDecoration(
                color: ColorConstant.primaryColor.withOpacity(isSender(messageThread.content[index])?1:0.1),
                borderRadius: BorderRadius.circular(30)
            ),
            child: CustomText(
              value: messageThread.content[index].content,
              color: isSender(messageThread.content[index])?ColorConstant.white:ColorConstant.darkText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              //     height: 1.28,
            ),
          )
        ],
      ),
    );
  }
  void dispatchGoToFirstPageEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<MessageBloc>(context)
        .add(GoToFirstPageEvent(token: widget.token));
  }
  bool isSender(Content content){
    if(content.senderId ==widget.user.id){
      return true;
    }
    return false;
  }
  void sendMessage(String recipientId ,String content,String token) async {
    myController.clear();
    cancelTimer();
    String id = widget.messageThread.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/messages");
    final response = await client.post(url,body: json.encode({
      "recipientId": recipientId,
      "content": content
    },
    ),headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print("sended");
      var url = Uri.parse("http://197.13.15.233:8787/api/v1/messages/threads/$id");
      final response = await client.get(url, headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        'Authorization': 'Bearer $token',
      },
      );
      if(response.statusCode ==200){
        final thread = MessageThread.fromJson(json.decode(response.body));
        thread.content= new List.from(thread.content.reversed);
        thread.content.removeWhere((item) => item.content== 'test');
        thread.id =id;
        setState(() {
          messageThread = thread;
        });
        startTimer();
      }else {
        final message = json.decode(response.body)["apierror"]['message'];
        print(response.body);
        print("excption thrad");
      }
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      print("excption");
    }
  }
  Future<void> checkForNewSharedLists(String token,String idThread) async {
    cancelTimer();
    String id = widget.messageThread.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/messages/threads/$id");
    final response = await client.get(url, headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      final thread = MessageThread.fromJson(json.decode(response.body));
      thread.content= new List.from(thread.content.reversed);
      thread.content.removeWhere((item) => item.content== 'test');
      thread.id =id;
      setState(() {
        messageThread = thread;
      });
      startTimer();
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      print("excption thrad");
    }


  }
  void onConnected() {
    print('Connected');
  }
// unconnected
  void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }
  void startTimer(){
    print("started");
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkForNewSharedLists(widget.token,widget.messageThread.id));
  }
  void cancelTimer(){
    print("cancled");
    timer.cancel();
  }
}

