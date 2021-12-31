import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/addImageCard.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/imagCard.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/afterEstimation.dart';

class PropertiesImageDisplay extends StatefulWidget {
  final bool fromProp ;
  final String token;
  final PropertiesModel propertiesModel;

  const PropertiesImageDisplay({Key key,this.token,this.propertiesModel,this.fromProp}) : super(key: key);
  @override
  _PropertiesImageDisplayState createState() => _PropertiesImageDisplayState();
}

class _PropertiesImageDisplayState extends State<PropertiesImageDisplay> {

  bool popUp = false;
  bool popUpErreur = false ;
  void handleClick(String value) {
    switch (value) {
      case 'Supprimer': dispatchGoToDeleteImagesDisplayEvent(widget.propertiesModel,widget.fromProp);
      break;
      case 'Retouche automatisé': print("Retouche automatisé");
      break;
      case 'Home staging virtuel': print("Home staging virtuel");
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
    PropertiesModel propertiesModel = widget.propertiesModel;
    String token = widget.token;
    bool fromProp =widget.fromProp;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: "les photos de bien".toUpperCase(),
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    //    dispatchGoHomeDisplayEvent();
                    print("ok");
                  },
                ),
                action: PopupMenuButton<String>(
                  padding: EdgeInsets.only(left: 30),
                  icon: SvgPicture.asset("Assets/Images/menudotsverticalIcon.svg",height: 20,width: 20,),
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Supprimer', 'Retouche automatisé','Home staging virtuel'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: CustomText(
                          value: choice,
                          color: ColorConstant.darkText,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList();
                  },
                ),
                /*InkWell(
              onTap: (){
                print("ok");
              },
              child: SvgPicture.asset("Assets/Images/menudotsverticalIcon.svg",height: 20,width: 20,),
            ),*/
              ),
              CustomBar(
                firstLine: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.round().toString()+" m²",
                secondLine: "10 rue AlbertMat - Virigneux 42140",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: GridView.builder(
                          itemCount: propertiesModel.fileBien.length+1,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if(index<propertiesModel.fileBien.length){
                              return ImageCard(imageId: propertiesModel.fileBien[index].id,height: 174,width: 174,token: token,);
                            }
                            //     return ClipRRect( borderRadius: BorderRadius.circular(10),child: Image.asset("Assets/Images/logo.png"));
                            return Container(
                              height: 174,
                              width: 174,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15,top: 15),
                                    child: FDottedLine(
                                      color: ColorConstant.primaryColor,
                                      strokeWidth: 2.0,
                                      dottedLength: 10.0,
                                      space: 2.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(35),
                                        child: SvgPicture.asset("Assets/Images/Groupe 3268.svg",height: 67,width: 67,),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                      child: SvgPicture.asset("Assets/Images/Groupe 9591.svg",width: 40,height: 40,),
                                      onTap: (){
                                        setState(() {
                                          setState(() {
                                            if(!((propertiesModel.fileBien.length) == 6)){
                                              popUp = true;
                                            }else{
                                              popUpErreur = true;
                                            }

                                          });
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 25,),
                      CustomButton(
                        text: "ENREGISTRER cette selection".toUpperCase(),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        height: 48,
                        letterSpacing: 0.7,
                        onPressed: (){
                          if(fromProp){
                            dispatchGoToPropertieDisplay(propertiesModel,);
                          }else{
                            dispatchGoToImagesSavedDisplayEvent(propertiesModel,token);
                          }
                        },
                      ),
                      SizedBox(height: 50,)
                    ],
                  ),
                ),
              )
            ],
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
                            value: "Vous pouvez profiter de notre service Séance photo",
                            color: ColorConstant.darkText,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
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
                                // _loadPicker(ImageSource.camera);
                                print("service");


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
                                dispatchGoToCameraEvent(propertiesModel,fromProp);
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
        popUpErreur? Stack(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  popUpErreur = false;
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset("Assets/Images/errorIcon.svg",),
                            SizedBox(
                              height: 20,
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: CustomText(
                                value: "Erreur",
                                color: ColorConstant.red,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Material(
                          type: MaterialType.transparency,
                          child: CustomText(
                            value: "Vous pouvez pas enregistrer plus que 6\nphotos pour un seul bien.",
                            color: ColorConstant.darkText,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              ),
            )
          ],
        ):Container()
      ],
    );

  }

  void dispatchGoToDeleteImagesDisplayEvent(PropertiesModel propertiesModel,bool fromProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToDeleteImagesDisplayEvent(propertiesModel: propertiesModel,fromProp: fromProp));
  }
  void dispatchGoToImagesSavedDisplayEvent(PropertiesModel propertiesModel,String token) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToImagesSavedDisplayEvent(propertiesModel: propertiesModel,token: token));
  }
  void dispatchGoTOGalleryEvent(PropertiesModel propertiesModel,bool fromProp) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoTOGalleryEvent(propertiesModel: propertiesModel,fromProp: fromProp));
  }
  void dispatchGoToCameraEvent(PropertiesModel propertiesModel,bool fromProp) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToCameraEvent(propertiesModel: propertiesModel,fromProp: fromProp));
  }
  void dispatchGoToPropertieDisplay(PropertiesModel propertiesModel) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToPropertieDisplay(propertiesModel: propertiesModel,token: widget.token));
  }
}
