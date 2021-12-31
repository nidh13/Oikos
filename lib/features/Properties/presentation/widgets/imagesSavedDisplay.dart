import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/addImageCard.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/imagCard.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import 'afterEstimation.dart';

class ImagesSavedDisplay extends StatefulWidget {
  final PropertiesModel propertiesModel;
  final String token ;
  final List<PropertiesModel>listProp;
  final User user;

  const ImagesSavedDisplay({Key key, this.propertiesModel, this.token,this.listProp,this.user}) : super(key: key);


  @override
  _ImagesSavedDisplayState createState() => _ImagesSavedDisplayState();
}

class _ImagesSavedDisplayState extends State<ImagesSavedDisplay> {
  @override
  Widget build(BuildContext context) {
    PropertiesModel propertiesModel =widget.propertiesModel;
    String token = widget.token;
    List<PropertiesModel> listProp=widget.listProp;
    User user =widget.user;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(user: user,token: token,listProp: listProp,),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/Images/backgroundImageCroped.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color(0xFF127939).withOpacity(0.52),
                          Color(0xFF103471),
                        ],
                        stops: [0.05, 1],
                        tileMode: TileMode.clamp
                    )
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    //check
                   // dispatchGoToPropertiesImagesDisplayEvent();
                    print("ok");
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomText(
                          value: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.round().toString()+" m²",
                          color: ColorConstant.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(icon :Icon(Icons.location_on_outlined, color: ColorConstant.grayText),iconSize: 15,),
                          CustomText(
                            value: "10 rue AlbertMat - Virigneux 42140",
                            color: ColorConstant.grayText,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 30,top: 20),
                    child: RobotoText(
                      color: ColorConstant.maxEstimationColor,
                      value: "€ "+propertiesModel.price.round().toString(),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                        height: 1,
                        thickness: 1,
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
                        height: 1,
                        thickness: 1,
                        color: ColorConstant.grayDriver
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                        height: 1,
                        thickness: 1,
                        color: ColorConstant.grayDriver
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20,bottom: 10),
                    child: CustomText(
                      value: "Photos",
                      color: ColorConstant.darkText,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: GridView.builder(
                      itemCount: propertiesModel.fileBien.length+1,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if(index==0){
                          return AddImageCard(height: 93,width: 93,onTap: (){
                            setState(() {
                              //  popUp =true;
                            });
                          },
                          );

                        }
                        //     return ClipRRect( borderRadius: BorderRadius.circular(10),child: Image.asset("Assets/Images/logo.png"));
                        return ImageCard(imageId: propertiesModel.fileBien[index-1].id,height: 93,width: 93,token: token,);
                      },
                    ),
                  ),
                  SizedBox(height: 50,),
                  CustomButton(
                    text: "Ajouter un texte d'annonce".toUpperCase(),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    height: 48,
                    letterSpacing: 0.7,
                    onPressed: (){
                      dispatchGoToAdTextDisplayEvent(propertiesModel);
                    },
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ],

      ),
    );
  }
 /* void dispatchGoToPropertiesImagesDisplayEvent() {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToPropertiesImagesDisplayEvent());
  }*/
  void dispatchGoToAdTextDisplayEvent(PropertiesModel propertiesModel) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToAdTextDisplayEvent(propertiesModel: propertiesModel));
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
