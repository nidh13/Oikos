import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/addImageCard.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/imagCard.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class PropertieDisplay extends StatefulWidget {
  final PropertiesModel propertiesModel;
  final String token ;
  final List<PropertiesModel>listProp;
  final User user;
  final FullCalendar calendar;
  const PropertieDisplay({Key key, this.propertiesModel, this.token,this.listProp,this.user,this.calendar}) : super(key: key);
  @override
  _PropertieDisplayState createState() => _PropertieDisplayState();
}

class _PropertieDisplayState extends State<PropertieDisplay> {
  List<String>listMenu;
  bool delete = false;
  @override
  void initState() {
    listMenu =menuStrings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PropertiesModel propertiesModel =widget.propertiesModel;
    String token = widget.token;
    User user =widget.user;
    List<PropertiesModel>listProp=widget.listProp;
     FullCalendar calendar=widget.calendar;
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: CustomBottomNavBar(token: token,user: user,listProp: listProp,),
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
                        //    dispatchGoToPropertiesImagesDisplayEvent();
                        print("ok");
                      },
                    ),
                    actions: [
                      PopupMenuButton<String>(
                        // padding: EdgeInsets.only(right: 5),
                        icon: SvgPicture.asset("Assets/Images/menudotsverticalIcon.svg",height: 20,width: 20,),
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          if(listMenu.length == 5){
                            return {listMenu[0], listMenu[1],listMenu[2],listMenu[3],listMenu[4]}.map((String choice) {
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
                          }
                          return {listMenu[0], listMenu[1],listMenu[2],listMenu[3]}.map((String choice) {
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
                    ],
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
                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                        child: CustomText(
                          value: "Description",
                          color: ColorConstant.darkText,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,bottom: 15),
                        child: CustomText(
                          value: propertiesModel.description,
                          color: ColorConstant.gray3Text,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
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
                                dispatchGoTOImageUpdateDisplayEvent(propertiesModel);
                              },
                              );

                            }
                            //     return ClipRRect( borderRadius: BorderRadius.circular(10),child: Image.asset("Assets/Images/logo.png"));
                            return ImageCard(imageId: propertiesModel.fileBien[index-1].id,height: 93,width: 93,token: token,);
                          },
                        ),
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              ),
            ],

          ),
        ),
        delete?Stack(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  delete = false;
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
                        Material(
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: ColorConstant.primaryColor,
                              size: 50,
                            ),
                          ),
                        ),
                        Material(
                          type: MaterialType.transparency,
                          child: CustomText(
                            value: "vous voullez supprrimer votre bien ?",
                            color: ColorConstant.dark,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
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
                                dispatchDeletePropertiesEvent(token,propertiesModel.id);
                              },
                              child: Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: CustomText(
                                    value: "Oui je veux",
                                    color: ColorConstant.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
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
                                setState(() {
                                  delete = false;
                                });
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

      ],
    );
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
  void handleClick(String value) {
    switch (value) {
      case 'Modifier': /*dispatchGoToDeleteImagesDisplayEvent();*/
      break;
      case 'Supprimer': setState(() {
        delete =true;
      });
        break;
      case 'Commander des services': print("Retouche automatisé");
      break;
      case 'Créer mon agenda': dispatchGoToDeleteImagesDisplayEvent(widget.propertiesModel,widget.listProp);
      break;
      case 'Agenda': dispatchGoToDeleteImagesDisplayEvent(widget.propertiesModel,widget.listProp);
      break;
      case 'Listes des Offers': dispatchGoToListOffersEvent(widget.propertiesModel,widget.listProp);
      break;
    }
  }
  List<String>menuStrings(){
    if(widget.calendar != null){
      return ['Modifier', 'Commander des services','Agenda',"Listes des Offers","Supprimer"];
    }
    return ['Modifier', 'Commander des services','Créer mon agenda',"Supprimer"];
  }
  void dispatchGoToDeleteImagesDisplayEvent(PropertiesModel propertiesModel,List<PropertiesModel> listProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(CreateCalendarEvent(propertiesModel: propertiesModel,listProp: listProp));
  }
  void dispatchDeletePropertiesEvent(String token,String id) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(DeletePropertiesEvent(token: token,id: id));
  }
  void dispatchGoToListOffersEvent(PropertiesModel propertiesModel,List<PropertiesModel> listProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoToListOffersEvent(propertiesModel:propertiesModel ,listProp:listProp ));
  }
  void dispatchGoTOImageUpdateDisplayEvent(PropertiesModel propertiesModel) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoTOImageUpdateDisplayEvent(propertiesModel: propertiesModel));
  }
}
