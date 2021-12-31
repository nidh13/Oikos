import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';


class PropertiesBeforeEstimation extends StatefulWidget {
  final User user;
  final String token;
  final PropertiesModel propertiesModel;
  final List<PropertiesModel>listProp;
  const PropertiesBeforeEstimation({Key key, this.user, this.token,this.propertiesModel,this.listProp}) : super(key: key);

  @override
  _PropertiesBeforeEstimationState createState() => _PropertiesBeforeEstimationState();
}

class _PropertiesBeforeEstimationState extends State<PropertiesBeforeEstimation> {
  @override
  Widget build(BuildContext context) {
    PropertiesModel propertiesModel =widget.propertiesModel;
    String token = widget.token;
    User user = widget.user;
    List<PropertiesModel>listProp=widget.listProp;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(token: token,user: user,listProp: listProp,),
      body: Column(
        children: [
          CustomAppBar(
            title: "MON BIEN À ESTIMER",
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
                //    dispatchGoHomeDisplayEvent();
                print("ok");
              },
            ),
            action: InkWell(
              onTap: (){
                print("ok");
              },
              child: SvgPicture.asset("Assets/Images/editIcon.svg",height: 18,width: 18,),
            ),
          ),
          CustomBar(
            firstLine: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.toString()+" m²",
            secondLine: "10 rue AlbertMat - Virigneux 42140",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20,left:20,top:30),
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
                        propertiesModel.piecesOfProperty.hasSallon? Column(
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
                                  value: propertiesModel.homeArea.toString()+" m²",
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
                  CustomButton(
                    text: "ESTIMATION D'OIKOS",
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    height: 48,
                    letterSpacing: 0.7,
                    onPressed: (){
                      dispatchEstimationPropertiesEvent(propertiesModel,token);
                    },
                  ),
                  SizedBox(height: 80,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void dispatchEstimationPropertiesEvent(PropertiesModel propertiesModel,String token) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(EstimationPropertiesEvent(propertiesModel: propertiesModel,token: token));
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

