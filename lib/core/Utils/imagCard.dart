import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class ImageCard extends StatelessWidget {
  final String imageId;
  final double height ;
  final double width ;
  final String token;

  ImageCard({this.imageId,this.height,this.width,this.token});

  @override
  Widget build(BuildContext context) {
    return ClipRRect( /*borderRadius: BorderRadius.circular(10),*/child: Container(height: height,width: width,
      child:Image.network("http://197.13.15.233:8787/api/v1/properties/mediatype-image/$imageId",
        fit: BoxFit.cover,
        width: height,
        height: width,
        key: ValueKey(new Random().nextInt(100)),
        headers: {
          "authorization": "Bearer $token",
          // Other headers if wanted
        },
        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return ClipOval(
            child: Container(
              width: width,
              height: height,
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
            width: width,
            height: height,
            fit: BoxFit.cover,

          );
        },
      ),
    )
    );
  }
}