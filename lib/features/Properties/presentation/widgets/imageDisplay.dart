import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/bloc.dart';
class ImageDisplay extends StatefulWidget {
  File image ;
  final PropertiesModel propertiesModel;
  final String token;
  final bool fromProp;
   ImageDisplay({Key key, this.image,this.propertiesModel,this.token,this.fromProp}) : super(key: key);

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  bool popUp = false;
  @override
  Widget build(BuildContext context) {
    File image = widget.image;
    PropertiesModel propertiesModel =widget.propertiesModel;
    String token = widget.token;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: "",
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    // dispatchGoHomeDisplayEvent(user,token);
                  },
                ),
                action: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        cropImage(image);
                      },
                      child: SvgPicture.asset("Assets/Images/cropIcon.svg",height: 20,width: 20,),
                    ),
                    SizedBox(width: 15,),
                    InkWell(
                      onTap: (){
                    //    print("ok");
                        dispatchGoToFilterImageEvent(image,propertiesModel,widget.fromProp);
                      },
                      child: SvgPicture.asset("Assets/Images/magicwand.svg",height: 20,width: 20,),
                    ),
                    SizedBox(width: 15,)
                    ,InkWell(
                      onTap: (){
                        print("ok");
                      },
                      child: SvgPicture.asset("Assets/Images/pencil.svg",height: 20,width: 20,),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),


            ],
          ),
          bottomSheet:  Container(
            height: 80,
            color: Color(0xff0060A2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'annuler'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Multi',
                        height: 1.1,
                        letterSpacing: 0.77,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: (){
                      print("ok");
                    },
                    child: SvgPicture.asset("Assets/Images/rotateIcon.svg",height: 20,width: 20,),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      popUp = true;
                    });
                  },
                  child: Text(
                    'confirmer'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Multi',
                      height: 1.1,
                      letterSpacing: 0.77,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
        popUp? Stack(
          children: [
            GestureDetector(
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
                        SvgPicture.asset("Assets/Images/camera.svg",),
                        Material(
                          type: MaterialType.transparency,
                          child: CustomText(
                            value: "Votre photo a été bien ajouter à votre Bien",
                            color: ColorConstant.darkText,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CustomButton(
                          text: "D'accord".toUpperCase(),
                          fontWeight:FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 0.7,
                          height: 48,
                          onPressed: (){
                            dispatchGoToPropertiesImagesDisplayEvent(image,propertiesModel,token,widget.fromProp);
                          },
                          minWidth: 135,
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
    );
  }
  void dispatchGoToPropertiesImagesDisplayEvent(File image,PropertiesModel propertiesModel,String token,bool fromProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToPropertiesImagesDisplayEvent(propertiesModel: propertiesModel,image: image,token: token,fromProp: fromProp));
  }
  void dispatchGoToFilterImageEvent(File image,PropertiesModel propertiesModel,bool fromProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToFilterImageEvent(image: image,propertiesModel: propertiesModel,fromProp: fromProp));
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
          toolbarColor: Color(0xFF07777B),
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
}
