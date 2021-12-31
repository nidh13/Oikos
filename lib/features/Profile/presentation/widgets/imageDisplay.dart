import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/features/Profile/presentation/bloc/bloc.dart';

class ImageDisplay extends StatefulWidget {
  final bool firstConexion;
    File image ;
    final String token;
   ImageDisplay({Key key, this.image,this.token,this.firstConexion}) : super(key: key);
  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {

  @override
  Widget build(BuildContext context) {
    File image = widget.image;
    String token = widget.token;
    bool firstConexion =widget.firstConexion;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Aperçu de la photo de profil".toUpperCase(),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
               // dispatchGoHomeDisplayEvent(user,token);
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                image ==null? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SvgPicture.asset(
                    "Assets/Images/avatar.svg",
                    fit: BoxFit.cover,
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.file(image,
                    fit: BoxFit.cover,
                  ),
                ),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Color(0xFF036995).withOpacity(0.5),
                    BlendMode.srcOut,
                  ), // This one will create the magic
                  child: Stack(
                   fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          backgroundBlendMode: BlendMode.dstOut,
                        ), // This one will handle background + difference out
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width / 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 10),
                    child: InkWell(
                      onTap: (){
                        cropImage(image);
                      },
                      child: SvgPicture.asset(
                        "Assets/Images/crop.svg",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CustomButton(
            text: "Enregister la photo de profil".toUpperCase(),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            height: 48,
            letterSpacing: 0.7,
            onPressed: (){
              dispatchCropEvent(image,token,firstConexion);
            },
          )

        ],
      ),
    );
  }
  Future cropImage(File image) async {
    dynamic cropped = await ImageCropper.cropImage(
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Recadrer".toUpperCase(),
          toolbarColor: ColorConstant.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      sourcePath: image.path,
      aspectRatio:
      CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    if(cropped != null){
      setState(() {
        widget.image=cropped;
      });
    }
  }
  void dispatchCropEvent(File image,String token,bool firstConexion) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ProfileBloc>(context)
        .add(CropEvent(image: image,token: token,firstConexion: firstConexion));
  }
}

    