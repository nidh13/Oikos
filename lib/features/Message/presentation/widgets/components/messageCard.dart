import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Message/domain/entities/chatMessage.dart';
class MessageCard extends StatelessWidget {
  final ChatMessage message;
  final String token;
  const MessageCard({Key key, this.message,this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
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
              color: ColorConstant.primaryColor.withOpacity(message.isSender?1:0.1),
              borderRadius: BorderRadius.circular(30)
            ),
            child: CustomText(
              value: message.text,
              color: message.isSender?ColorConstant.white:ColorConstant.darkText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              //     height: 1.28,
            ),
          )
        ],
      ),
    );
  }
}
