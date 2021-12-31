import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customCounter.dart';
import 'package:oikosmobile/core/Utils/customImputBien.dart';
import 'package:oikosmobile/core/Utils/customRadioBar.dart';
import 'package:oikosmobile/core/Utils/customRadioButton.dart';
import 'package:oikosmobile/core/Utils/customSwitch.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/customThreeRadioBar.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/helpWidget.dart';
import 'package:oikosmobile/core/Utils/termPolicyWidget.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class UpdatePropertiesDisplay extends StatefulWidget {
  final User user;
  final String token;
  final PropertiesModel propertiesModel;
  final List<PropertiesModel>listProp;

  const UpdatePropertiesDisplay({Key key, this.user, this.token, this.propertiesModel, this.listProp}) : super(key: key);
  @override
  _UpdatePropertiesDisplayState createState() => _UpdatePropertiesDisplayState();
}

class _UpdatePropertiesDisplayState extends State<UpdatePropertiesDisplay> {
  int _groupValue = 1;
  int _groupValue7 =0 ;
  bool houseChecked = false;
  bool villaChecked = false;
  bool apartmentChecked = false;
  bool workshopChecked = false;
  bool propertyChecked = false;
  bool lifeAnnuityChecked = false;

  int piecesNumber=1;
  int roomNumber=1;
  int parkingPlaceNumber=1;

  bool isSwitchedCellar = false;
  bool isSwitchedPool = false;
  bool isSwitchedGarden = false;
  bool isSwitchedBalcony = false;
  bool isSwitchedGarage = false;
  bool isSwitchedTerrace = false;
  bool isSwitchedKitchen = false;
  bool isSwitchedLivingRoom = false;
  bool isSwitchedNorth = false;
  bool isSwitchedSouth = false;
  bool isSwitchedEast = false;
  bool isSwitchedWest = false;

  int _groupValue1 = 1;
  int _groupValue2 = 1;
  int _groupValue3 = 1;
  int _groupValue4 = 1;
  int _groupValue5 = 1;
  int _groupValue6 = 1;

  bool termPolicy = false;

  bool loading = false;

  String valueChoose;
  String propLocation;
  double allArea;
  double homeArea;
  double livingArea;
  String yearOfConstruction;
  List<String> listItem =["entre ","entre ","item3","item4","item5","item6","item7","item8","entre",];
  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    String token = widget.token;
    List<PropertiesModel>listProp = widget.listProp;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(user: user,token: token,listProp: listProp,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
            title: "Modifier Mon BIEN",
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
               // dispatchGoHomeDisplayEvent(user,token);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  CustomRadioBar(
                    text: "Vous-êtes le propriétaire de ce bien?",
                    groupValue:_groupValue,
                    onChangedNo: (value){
                      setState(() {
                        _groupValue=2;
                      });
                    },
                    onChangedYes: (value){
                      setState(() {
                        _groupValue=1;
                      });
                    } ,
                  ),
                  SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomText(
                          value: "Cathégorie de Bien",
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: ColorConstant.darkText,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomRadioButton(
                              text: "Maison",
                              checked: houseChecked,
                              onTap: (){
                                setState(() {
                                  _groupValue7 = 1;
                                  houseChecked = true;
                                  villaChecked = false;
                                  apartmentChecked = false;
                                  workshopChecked = false;
                                  propertyChecked = false;
                                  lifeAnnuityChecked = false;

                                });
                              },
                            ),
                            CustomRadioButton(
                              text: "Villa",
                              checked: villaChecked,
                              onTap: (){
                                setState(() {
                                  _groupValue7 = 2;
                                  houseChecked = false;
                                  villaChecked = true;
                                  apartmentChecked = false;
                                  workshopChecked = false;
                                  propertyChecked = false;
                                  lifeAnnuityChecked = false;
                                });
                              },
                            ),
                            CustomRadioButton(
                              text: "Appartement",
                              checked: apartmentChecked,
                              onTap: (){
                                setState(() {
                                  _groupValue7 =3;
                                  houseChecked = false;
                                  villaChecked = false;
                                  apartmentChecked = true;
                                  workshopChecked = false;
                                  propertyChecked = false;
                                  lifeAnnuityChecked = false;
                                });
                              },
                            ),
                            CustomRadioButton(
                              text: "Atelier",
                              checked: workshopChecked,
                              onTap: (){
                                setState(() {
                                  _groupValue7 =4;
                                  houseChecked = false;
                                  villaChecked = false;
                                  apartmentChecked = false;
                                  workshopChecked = true;
                                  propertyChecked = false;
                                  lifeAnnuityChecked = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomRadioButton(
                              text: "Propriété",
                              checked: propertyChecked,
                              onTap: (){
                                setState(() {
                                  _groupValue7 = 5;
                                  houseChecked = false;
                                  villaChecked = false;
                                  apartmentChecked = false;
                                  workshopChecked = false;
                                  propertyChecked = true;
                                  lifeAnnuityChecked = false;
                                });
                              },
                            ),
                            SizedBox(width: 30,),
                            CustomRadioButton(
                              text: "Viager",
                              checked: lifeAnnuityChecked,
                              onTap: (){
                                setState(() {
                                  _groupValue7=6;
                                  houseChecked = false;
                                  villaChecked = false;
                                  apartmentChecked = false;
                                  workshopChecked = false;
                                  propertyChecked = false;
                                  lifeAnnuityChecked = true;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomInputBien(
                    text: "Emplacement de Bien",
                    // initialValue: propLocation,
                    onChanged: (value){
                      //    propLocation = value;
                    },
                    hint: "10 rue AlbertMat - Virigneux 42140",
                    suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
                    textInputType: TextInputType.visiblePassword,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset("Assets/Images/Locs.svg",),
                    ),
                  ),
                  SizedBox(height: 10,),
                  CustomCounter(
                    value: piecesNumber,
                    text: "Nombre de pièces",
                    add:(){
                      setState(() {

                        piecesNumber =piecesNumber+1;
                      });
                    },
                    sub:(){
                      if(piecesNumber>1){
                        setState(() {
                          piecesNumber =piecesNumber-1;
                        });
                      }},
                  ),
                  SizedBox(height: 10,),
                  CustomCounter(
                    value: roomNumber,
                    text: "Nombre de chambre",
                    add:(){
                      setState(() {

                        roomNumber =roomNumber+1;
                      });
                    },
                    sub:(){
                      if(roomNumber>1){
                        setState(() {
                          roomNumber =roomNumber-1;
                        });
                      }},
                  ),
                  SizedBox(height: 10,),
                  HelpWidget(text: "La cuisine , la salle de bain et les toilettes ne sont pas à prendre en compte",),
                  SizedBox(height: 10,),
                  CustomCounter(
                    value: parkingPlaceNumber,
                    text: "Nombre des places de parking",
                    add:(){
                      setState(() {

                        parkingPlaceNumber =parkingPlaceNumber+1;
                      });
                    },
                    sub:(){
                      if(parkingPlaceNumber>1){
                        setState(() {
                          parkingPlaceNumber =parkingPlaceNumber-1;
                        });
                      }},
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSwitch(
                              text: "Sallon",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedLivingRoom =value;
                                });
                              },
                              isSwitched: isSwitchedLivingRoom,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: CustomSwitch(
                                text: "Cuisine",
                                onChanged: (value){
                                  setState(() {
                                    isSwitchedKitchen =value;
                                  });
                                },
                                isSwitched: isSwitchedKitchen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSwitch(
                              text: "Terasse",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedTerrace =value;
                                });
                              },
                              isSwitched: isSwitchedTerrace,
                            ),
                            CustomSwitch(
                              text: "Garage",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedGarage =value;
                                });
                              },
                              isSwitched: isSwitchedGarage,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSwitch(
                              text: "Balcon",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedBalcony =value;
                                });
                              },
                              isSwitched: isSwitchedBalcony,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: CustomSwitch(
                                text: "Jardin",
                                onChanged: (value){
                                  setState(() {
                                    isSwitchedGarden =value;
                                  });
                                },
                                isSwitched: isSwitchedGarden,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSwitch(
                              text: "Cave",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedCellar =value;
                                });
                              },
                              isSwitched: isSwitchedCellar,
                            ),
                            CustomSwitch(
                              text: "Piscine",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedPool =value;
                                });
                              },
                              isSwitched: isSwitchedPool,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomInputBien(
                    text: "Surface m2",
                    initialValue: (allArea == null)?null:allArea.round().toString(),
                    onChanged: (value){
                      allArea = double.parse(value);
                    },
                    hint: "Surface m2",
                    suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  CustomInputBien(
                    initialValue: (yearOfConstruction== null)?null:yearOfConstruction,
                    text: "Année de construction",
                    onChanged: (value){
                      yearOfConstruction =value.toString();
                    },
                    hint: "Année de construction",
                    suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  CustomRadioBar(
                    text: "Des travaux à prévoir",
                    groupValue:_groupValue1,
                    onChangedNo: (value){
                      setState(() {
                        _groupValue1=2;
                      });
                    },
                    onChangedYes: (value){
                      setState(() {
                        _groupValue1=1;
                      });
                    } ,
                  ),
                  SizedBox(height: 20,),
                  CustomInputBien(
                    text: "Surface en m2 de terrain ( Bâti de la maison inclus )",
                    initialValue: (homeArea== null)?null:homeArea.round().toString(),
                    onChanged: (value){
                      homeArea=double.parse(value);
                    },
                    hint: "Surface en m2 de terrain",
                    suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  CustomInputBien(
                    initialValue: (livingArea== null)?null:livingArea.round().toString(),
                    text: "Surface en m2 de séjour",
                    onChanged: (value){
                      livingArea =double.parse(value);
                    },
                    hint: "Surface en m2 de séjour",
                    suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  CustomRadioBar(
                    text: "Avez-vous une dépendance ?",
                    groupValue:_groupValue2,
                    onChangedNo: (value){
                      setState(() {
                        _groupValue2=2;
                      });
                    },
                    onChangedYes: (value){
                      setState(() {
                        _groupValue2=1;
                      });
                    } ,
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomText(
                          value: "Exportation de votre Bien",
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: ColorConstant.darkText,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSwitch(
                              text: "Nord",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedNorth=value;
                                });
                              },
                              isSwitched: isSwitchedNorth,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 13),
                              child: CustomSwitch(
                                text: "Sud",
                                onChanged: (value){
                                  setState(() {
                                    isSwitchedSouth =value;
                                  });
                                },
                                isSwitched: isSwitchedSouth,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSwitch(
                              text: "Est",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedEast=value;
                                });
                              },
                              isSwitched: isSwitchedEast,
                            ),
                            CustomSwitch(
                              text: "Ouest",
                              onChanged: (value){
                                setState(() {
                                  isSwitchedWest =value;
                                });
                              },
                              isSwitched: isSwitchedWest,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomThreeRadioBar(
                    text: "La vue de votre Bien",
                    groupValue: _groupValue3,
                    firstChoiceText: "Vis-à-vis",
                    secondChoiceText: "Dégagée",
                    thirdChoiceText: "Exceptionnelle",
                    firstChoice: (value){
                      setState(() {
                        _groupValue3=1;
                      });
                    },
                    secondChoice: (value){
                      setState(() {
                        _groupValue3=2;
                      });
                    },
                    thirdChoice: (value){
                      setState(() {
                        _groupValue3=3;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  HelpWidget(
                    text: "Une vue peut être qualifiée d’exceptionnelle lorsque le bien donne sur un monument ou un élément naturel notable comme la mer, la montagne etc...",
                  ),
                  SizedBox(height: 20,),
                  CustomThreeRadioBar(
                    text: "Standing de votre Bien",
                    groupValue: _groupValue4,
                    firstChoiceText: "Moyen",
                    secondChoiceText: "Standard",
                    thirdChoiceText: "Exceptionnel",
                    firstChoice: (value){
                      setState(() {
                        _groupValue4=1;
                      });
                    },
                    secondChoice: (value){
                      setState(() {
                        _groupValue4=2;
                      });
                    },
                    thirdChoice: (value){
                      setState(() {
                        _groupValue4=3;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  HelpWidget(
                    text: "Nous entendons par ‘Standing’, le niveau de l’habitation en matière de qualité de construction,d'équipements et de confort.",
                  ),
                  SizedBox(height: 20,),
                  CustomRadioBar(
                    text: "Votre Bien est mitoyen",
                    groupValue:_groupValue5,
                    onChangedNo: (value){
                      setState(() {
                        _groupValue5=2;
                      });
                    },
                    onChangedYes: (value){
                      setState(() {
                        _groupValue5=1;
                      });
                    } ,
                  ),
                  SizedBox(height: 20,),
                  CustomThreeRadioBar(
                    text: "Emplacement de votre Bien",
                    groupValue: _groupValue6,
                    firstChoiceText: "Bruyant",
                    secondChoiceText: "Standard",
                    thirdChoiceText: "Calme",
                    firstChoice: (value){
                      setState(() {
                        _groupValue6=1;
                      });
                    },
                    secondChoice: (value){
                      setState(() {
                        _groupValue6=2;
                      });
                    },
                    thirdChoice: (value){
                      setState(() {
                        _groupValue6=3;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  HelpWidget(
                    text: "Bruyant : proche d’artères à circulation dense, voies ferrées, aéroport etc... Standard : proche de rues animées, commerces ou restaurants etc... Calme : retiré ou donnant sur cour, en zone résidentielle etc...",
                  ),
                  SizedBox(height: 30,),
                  TermPolicyWidget(
                    value: termPolicy,
                    onChanged: (value){
                      setState(() {
                        termPolicy =value;
                      });
                    },
                    text: "En soumettant ce formulaire, j’accepte que les informations saisies soient exploitées dans le cadre de la relation commerciale qui peut en découler.",
                  ),
                  SizedBox(height: 40,),
                  CustomButton(
                    text: "SOUMETTRE",
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    height: 48,
                    letterSpacing: 0.7,
                    onPressed: (){
                      Location location =Location(latitude: 0,longitude: 0);
                      Address address =Address(stateFull: "StringME",city: "CityME",street: "StringME",zipCode: "StringME");
                      PiecesOfProperty piecesOfProperty = PiecesOfProperty(
                        hasTerrasse: isSwitchedTerrace,
                        hasPiscine: isSwitchedPool,
                        hasJardin: isSwitchedGarden,
                        hasGarage: isSwitchedGarage,
                        hasCuisine: isSwitchedKitchen,
                        hasCave: isSwitchedCellar,
                        hasBalcon: isSwitchedBalcony,
                        hasSallon: isSwitchedLivingRoom,
                      );
                      PropExport propExport = PropExport(
                        isOuest: isSwitchedWest,
                        isEst: isSwitchedEast,
                        isSud: isSwitchedSouth,
                        isNord: isSwitchedNorth,
                      );
                      PropertiesModel propertiesModel = PropertiesModel(
                        id: widget.propertiesModel.id,
                          price: widget.propertiesModel.price,
                          userId: widget.propertiesModel.userId,
                          typeofprop: categoryFromInt(_groupValue7),
                          typepropInt: typfOfPropIntFromInt(_groupValue7),
                          vueProp:vuePropFromInt(_groupValue3),
                          propLocation: propLocationFromInt(_groupValue6),
                          propStanding: propStandingFromInt(_groupValue4),
                          allArea: allArea,
                          homeArea: homeArea,
                          livingArea: livingArea,
                          hasDependancy: fromIntToBool(_groupValue2),
                          description: widget.propertiesModel.description,
                          nbBedrooms: roomNumber,
                          nbRooms: piecesNumber,
                          nbParkingPlaces: parkingPlaceNumber,
                          hasPlannedWork: fromIntToBool(_groupValue1),
                          nbFloors: 2,
                          yearConstruction: yearOfConstruction,
                          livingSpace: 100,
                          owner: fromIntToBool(_groupValue),
                          adjoining: fromIntToBool(_groupValue5),
                          location: location,
                          address: address,
                          piecesOfProperty: piecesOfProperty,
                          propExport: propExport
                      );
                      dispatchUpdatePropertiesEvent(token,propertiesModel);
                    },
                  ),
                  SizedBox(height: 60,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  String  categoryFromInt(int value){
    switch (value){
      case 1 :
        return 'MAISON';
        break;
      case 2 :
        return 'VILLA';
        break;
      case 3 :
        return 'APPARTEMENT';
        break;
      case 4 :
        return 'ATELIER';
        break;
      case 5 :
        return 'PROPRIETE';
        break;
      case 6 :
        return 'VIAGER';
        break;
      default :
        return "";
    }}
  int typfOfPropIntFromInt(int value){
    switch (value){
      case 1 :
        return 2;
        break;
      case 2 :
        return 3;
        break;
      case 3 :
        return 1;
        break;
      case 4 :
        return 4;
        break;
      case 5 :
        return 1;
        break;
      case 6 :
        return 1;
        break;
    }}
  String  vuePropFromInt(int value){
    switch (value){
      case 1:
        return "Vis_a_vis";
      case 2 :
        return "Degagee";
        break;
      case 3 :
        return "Exceptionnelle";

    }}
  String  propStandingFromInt(int value){
    switch (value){
      case 1 :
        return "Moyen";
      case 2 :
        return "Standard";
        break;
      case 3 :
        return "Exceptionnel";

    }}
  String  propLocationFromInt(int value){
    switch (value){
      case 1 :
        return "Bruyant";
      case 2 :
        return "Standard";
        break;
      case 3 :
        return "Calme";
    }}
  bool fromIntToBool(int value){
    if(value == 1){
      return true;
    }
    return false;
  }
  void init(){
    PropertiesModel propertiesModel =widget.propertiesModel;
    _groupValue = propertiesModel.owner?1:0;
    piecesNumber=propertiesModel.nbRooms;
    yearOfConstruction=propertiesModel.yearConstruction;
    roomNumber=propertiesModel.nbBedrooms;
    parkingPlaceNumber=propertiesModel.nbParkingPlaces;
    isSwitchedCellar = propertiesModel.piecesOfProperty.hasCave;
    isSwitchedPool = propertiesModel.piecesOfProperty.hasPiscine ;
    isSwitchedGarden = propertiesModel.piecesOfProperty.hasJardin;
    isSwitchedBalcony = propertiesModel.piecesOfProperty.hasBalcon;
    isSwitchedGarage = propertiesModel.piecesOfProperty.hasGarage;
    isSwitchedTerrace = propertiesModel.piecesOfProperty.hasTerrasse;
    isSwitchedKitchen = propertiesModel.piecesOfProperty.hasCuisine;
    isSwitchedLivingRoom = propertiesModel.piecesOfProperty.hasSallon;
    isSwitchedNorth = propertiesModel.propExport.isNord;
    isSwitchedSouth = propertiesModel.propExport.isSud;
    isSwitchedEast = propertiesModel.propExport.isEst;
    isSwitchedWest = propertiesModel.propExport.isOuest;
    _groupValue1 = propertiesModel.hasPlannedWork?1:2;
    _groupValue2 = propertiesModel.hasDependancy?1:2;
    _groupValue3 = intFromVueProp(propertiesModel.vueProp);
    _groupValue4 = intFromPropStanding(propertiesModel.propStanding);
    _groupValue5 = propertiesModel.adjoining?1:2;
    _groupValue6 = intFromPropLocation(propertiesModel.propLocation);

    bool termPolicy = false;
    String valueChoose;

    _groupValue7 = intFromCategory(propertiesModel.typeofprop);
    switch (_groupValue7){
      case 1 :
        houseChecked = true;
        break;
      case 2 :
        villaChecked = true;
        break;
      case 3 :
        apartmentChecked = true;
        break;
      case 4 :
        workshopChecked = true;
        break;
      case 5 :
        propertyChecked = true;
        break;
      case 6 :
        lifeAnnuityChecked = true;
        break;
    }
    propLocation=propertiesModel.propLocation;
    allArea=propertiesModel.allArea;
    homeArea = propertiesModel.homeArea;
    livingArea =propertiesModel.livingArea;
  }
  int intFromCategory(String value){
    switch (value.toUpperCase()){
      case 'MAISON' :
        return 1;
        break;
      case 'VILLA' :
        return 2;
        break;
      case 'APPARTEMENT':
        return 3;
        break;
      case 'ATELIER' :
        return 4;
        break;
      case 'PROPRIETE':
        return 5;
        break;
      case 'VIAGER':
        return 6;
        break;
    }
  }
  int intFromVueProp(String value){
    switch(value){
      case "Vis_a_vis":
        return 1;
        break;
      case  "Degagee" :
        return 2;
        break;
      case "Exceptionnelle" :
        return 3;
        break;
    }
  }
  int intFromPropStanding(String value){
    switch(value){
      case "Moyen":
        return 1;
        break;
      case  "Standard" :
        return 2;
        break;
      case "Exceptionnel" :
        return 3;
        break;
    }
  }
  int intFromPropLocation(String value){
    switch(value){
      case "Bruyant":
        return 1;
        break;
      case  "Standard" :
        return 2;
        break;
      case "Calme":
        return 3;
        break;
    }
  }
  void dispatchUpdatePropertiesEvent(String token ,PropertiesModel propertiesModel) {
    print("from display token");
    print(token);
    BlocProvider.of<PropertiesBloc>(context)
        .add(UpdatePropertiesEvent(token:token,propertiesModel: propertiesModel ));
  }

}
