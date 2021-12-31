import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customServiceButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/servicesId.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Service/domain/entities/order.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class ServicesDisplay extends StatefulWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;
  final Orders orders;

  const ServicesDisplay({Key key, this.user, this.token, this.listProp,this.orders}) : super(key: key);
  @override
  _ServicesDisplayState createState() => _ServicesDisplayState();
}

class _ServicesDisplayState extends State<ServicesDisplay> {
  bool photoPayed = false;
  bool popUpErreur = false;
  @override
  void initState() {
    photoPayed =payedPhoto(widget.orders);
    print(photoPayed);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    User user =widget.user;
    List<PropertiesModel>listProp=widget.listProp;
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: CustomBottomNavBar(token: token,user: user,listProp: listProp,),
          body: Column(
            children: [
              CustomAppBar(
                title: "Services".toUpperCase(),
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    //    dispatchGoHomeDisplayEvent();
                    print("ok");
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomServiceButton(
                          text: "Réception\net Filtre des appels",
                          svgIcon: 'Assets/Images/callReception.svg',
                          isPaid: false,
                          onPressed: (){
                          },
                        ),
                        CustomServiceButton(
                          text: "Séance Photo\n",
                          svgIcon: 'Assets/Images/cameraService.svg',
                          isPaid: photoPayed,
                          onPressed: (){
                            if(photoPayed){
                              setState(() {
                                popUpErreur=true;
                              });
                            }else{
                              List<Pack>packs =[Pack(color: 1,amount: 250,desc1: "12 photos + Visite virtuelle",desc2: "Durée du photoshoot 45min",rang: 1),
                                Pack(color: 2,amount: 320,desc1: "22 photos + Visite virtuelle",desc2: "Durée du photoshoot 1h30min",rang: 2),
                                Pack(color: 3,amount: 450,desc1: "35 photos +Visite virtuelle + Visite en drone",desc2: "Durée du photoshoot 2h30min",rang: 3),];
                              dispatchGoToOnBoardingEvent(packs);
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomServiceButton(
                          text: "Visite Virtuelle",
                          svgIcon: 'Assets/Images/virtualViste.svg',
                          isPaid: false,
                          onPressed: (){
                          },
                        ),
                        CustomServiceButton(
                          text: "Home Staging",
                          svgIcon: 'Assets/Images/homeStanding.svg',
                          isPaid: false,
                          onPressed: (){
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomServiceButton(
                          text: "Diagnostique\nImmobilier",
                          svgIcon: 'Assets/Images/diagnostique.svg',
                          isPaid: false,
                          onPressed: (){
                          },
                        ),
                        CustomServiceButton(
                          text: "Boosteur\nd'Annonces",
                          svgIcon: 'Assets/Images/callReception.svg',
                          isPaid: false,
                          onPressed: (){
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
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
                            value: "Vous avez dija bénéficié le service photo\nle secretaire va vous contacter",
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
  void dispatchGoToOnBoardingEvent(List<Pack>packs) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToOnBoardingEvent(packs: packs));
  }
  bool payedPhoto(Orders orders){
    for(var content in orders.content){
      if(content.serviceID ==ServicesId.SEANCE_PHOTO){
        return true;
      }
    }
    return false;
  }
}
