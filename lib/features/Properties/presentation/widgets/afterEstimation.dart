import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/addImageCard.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/imagCard.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class AfterEstimation extends StatefulWidget {
  final PropertiesModel propertiesModel;
  final String token ;
  final List<PropertiesModel>listProp;
  final User user;

  const AfterEstimation({Key key, this.propertiesModel, this.token,this.listProp,this.user}) : super(key: key);
  @override
  _AfterEstimationState createState() => _AfterEstimationState();
}

class _AfterEstimationState extends State<AfterEstimation> {
  bool popUp = false;
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: CustomBottomNavBar(token: token,user: user,listProp: listProp,),
          body: Column(
            children: [
              CustomAppBar(
                title: "MON BIEN",
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    //    dispatchGoHomeDisplayEvent();
                    print("ok");
                  },
                ),
              ),
              CustomBar(
                firstLine: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.toString()+" m²",
                secondLine: "10 rue AlbertMat - Virigneux 42140",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: RobotoText(
                            color: ColorConstant.maxEstimationColor,
                            value: "€ "+propertiesModel.price.round().toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                            height: 2,
                            thickness: 2,
                            color: ColorConstant.grayDriver
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("Assets/Images/bed.svg"),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: CustomText(
                                    value: propertiesModel.nbBedrooms.toString()+" Chambres",
                                    color: ColorConstant.grayText,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            propertiesModel.piecesOfProperty.hasCuisine? Column(
                              children: [
                                SvgPicture.asset("Assets/Images/cutlery.svg"),
                                CustomText(
                                  value: "Cuisine",
                                  color: ColorConstant.grayText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ):Container(),
                            propertiesModel.piecesOfProperty.hasSallon?Column(
                              children: [
                                SvgPicture.asset("Assets/Images/salon.svg"),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: CustomText(
                                    value: "Sallon",
                                    color: ColorConstant.grayText,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ):Container(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20,left:20),
                        child: Divider(
                            height: 2,
                            thickness: 2,
                            color: ColorConstant.grayDriver
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    propertiesModel.piecesOfProperty.hasTerrasse?
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),):
                                    IconButton(icon :Icon(Icons.close, color: Colors.red),),
                                    CustomText(
                                      value: "Terasse",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    propertiesModel.piecesOfProperty.hasBalcon?
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),):
                                    IconButton(icon :Icon(Icons.close, color: Colors.red),),
                                    CustomText(
                                      value: "Balcon",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    propertiesModel.piecesOfProperty.hasCave?
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),):
                                    IconButton(icon :Icon(Icons.close, color: Colors.red),),
                                    CustomText(
                                      value: "Cave",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),),
                                    CustomText(
                                      value: propertiesModel.homeArea.round().toString()+" m²",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(

                                  children: [
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),),
                                    CustomText(
                                      value: "Vue "+propertiesModel.vueProp.toString(),
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(

                                  children: [
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),),
                                    CustomText(
                                      value: propertiesModel.propStanding.toString()+" Standing",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    propertiesModel.piecesOfProperty.hasGarage?
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),):
                                    IconButton(icon :Icon(Icons.close, color: Colors.red),),
                                    CustomText(
                                      value: "Garage",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    propertiesModel.piecesOfProperty.hasJardin?
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),):
                                    IconButton(icon :Icon(Icons.close, color: Colors.red),),
                                    CustomText(
                                      value: "Jardin",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    propertiesModel.piecesOfProperty.hasPiscine?
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),):
                                    IconButton(icon :Icon(Icons.close, color: Colors.red),),
                                    CustomText(
                                      value: "Piscine",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),),
                                    CustomText(
                                      value: "Depuit 2005",
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(

                                  children: [
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),),
                                    CustomText(
                                      value: location(propertiesModel),
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(icon :Icon(Icons.done, color: Colors.green),),
                                    CustomText(
                                      value: "Emplacement "+propertiesModel.propLocation,
                                      color: ColorConstant.darkTextInfo,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40,top: 20),
                        child: AddImageCard(height: 93,width: 93,onTap: (){
                          setState(() {
                            popUp =true;
                          });
                        },
                        ),
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                ),
              ),
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
                                print("service camera");
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
                                dispatchGoToCameraEvent(propertiesModel);
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
        ):Container()
      ],
    );
  }
  void dispatchGoTOGalleryEvent(PropertiesModel propertiesModel) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoTOGalleryEvent(propertiesModel: propertiesModel));
  }
  void dispatchGoToCameraEvent(PropertiesModel propertiesModel) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToCameraEvent(propertiesModel: propertiesModel,fromProp: false));
  }
  String location (PropertiesModel propertiesModel){
    String s="";
    if(propertiesModel.propExport.isNord){
      s+="Nord";
      if(propertiesModel.propExport.isOuest){
        s+="-Ouest";
      }
      if(propertiesModel.propExport.isEst){
        s+="-Est";
      }
    }
    if(propertiesModel.propExport.isSud){
      s+="Sud";
      if(propertiesModel.propExport.isOuest){
        s+="-Ouest";
      }
      if(propertiesModel.propExport.isEst){
        s+="-Est";
      }
    }
    if(!propertiesModel.propExport.isSud && !propertiesModel.propExport.isNord){
      if(propertiesModel.propExport.isOuest){
        s+="Ouest";
        if(propertiesModel.propExport.isEst){
          s+="-Est";
        }
      }
      if(propertiesModel.propExport.isEst){
        s+="Est";
        if(propertiesModel.propExport.isOuest){
          s+="-Ouest";
        }
      }
    }
    return s;

  }
}




