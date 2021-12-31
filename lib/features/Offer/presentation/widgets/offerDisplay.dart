import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customImputBien.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/customThreeRadioBar.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/offer_bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class OfferDisplay extends StatefulWidget {
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;
  final Offer offer ;
  final PropertiesModel propertiesModel;
  final User sender;

  const OfferDisplay({Key key, this.user, this.token, this.listProp, this.offer, this.propertiesModel, this.sender}) : super(key: key);
  @override
  _OfferDisplayState createState() => _OfferDisplayState();
}

class _OfferDisplayState extends State<OfferDisplay> {
  int _groupValue3 = 0;
  bool somethingSelected = false;
  bool popUp = false;
  DateTime pickedDate;
  String limitDate;
  double price;

  @override
  void initState() {
    pickedDate=DateTime.now();
    var month;
    var day;
    if(pickedDate.month<10){
      month = "0${pickedDate.month}";
    }else{
      month = "${pickedDate.month}";
    }
    if(pickedDate.day<10){
      day = "0${pickedDate.day}";
    }else{
      day = "${pickedDate.day}";
    }
    limitDate ="${pickedDate.year}-"+month+"-"+day;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    User user=widget.user;
    String token =widget.token;
    List<PropertiesModel>listProp=widget.listProp;
    Offer offer =widget.offer;
    PropertiesModel propertiesModel =widget.propertiesModel;
    User sender =widget.sender;
    String senderName = sender.firstName;
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: somethingSelected?null:CustomBottomNavBar(token: token,user: user,listProp: listProp,),
          body: Column(
            children: [
              CustomAppBar(
                title: "Offre N° 11-A255".toUpperCase(),
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    dispatchGoToOfferListEvent(token,propertiesModel.id);
                  },
                ),
                action: PopupMenuButton<String>(
                  // padding: EdgeInsets.only(right: 5),
                  icon: SvgPicture.asset("Assets/Images/menudotsverticalIcon.svg",height: 20,width: 20,),
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Envoyer un message pour l acheteur',}.map((String choice) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                },
                                icon: SvgPicture.asset('Assets/Images/agendaIcon.svg',color: ColorConstant.blueText,width: 16,height: 16,),
                                label: RobotoText(
                                  value: dateFromIsoString(offer.createdAt),
                                  color: ColorConstant.blueText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                )
                            ),
                            TextButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset('Assets/Images/agendaIcon.svg',color: ColorConstant.blueText,width: 16,height: 16,),
                                label: RobotoText(
                                  value: timeFromIsoString(offer.createdAt),
                                  color: ColorConstant.blueText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width-40,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFFEAF5FE),
                          border: Border.all(
                            color: Color(0xFFB4DCFF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              value: sender.firstName+" "+sender.lastName,
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              value: "App n°3 - 6 rue Victor",
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              value: "83200 - Toulon",
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              value: "+33"+sender.phoneNumber.toString(),
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              value: sender.email,
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              value: "À la date du ("+dateFromIsoString(offer.createdAt)+"), je soussigné, Monsieur/Madame ("+sender.firstName+" "+sender.lastName+"), dénommé le promettant, m’engage à acheter, en cas d’acceptation de la présente offre, de façon ferme et irrévocable, (nature du bien : "+propertiesModel.typeofprop+") désigné ci-dessous :",
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              value: "Lieu de localisation : 10 rue AlbertMat - Virigneux 42140",
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              value: "Type de bien : "+propertiesModel.typeofprop,
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              value: "Superficie : "+propertiesModel.allArea.round().toString()+"m²",
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              value: "Prix : "+offer.amount.round().toString()+"€",
                              color: Color(0xFF393939),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 1,
                                    groupValue: _groupValue3,
                                    activeColor: ColorConstant.primaryColor,
                                    onChanged: (value){
                                      setState(() {
                                        somethingSelected = true;
                                        _groupValue3 =1;
                                      });
                                    }
                                ),
                                RobotoText(
                                  value: "Accepter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.gray,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: 2,
                                  groupValue: _groupValue3,
                                  activeColor: ColorConstant.primaryColor,
                                  onChanged: (value){
                                    setState(() {
                                      somethingSelected = true;
                                      _groupValue3 =2;
                                    });
                                  },
                                ),
                                RobotoText(
                                  value: "Refuser",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.gray,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: 3,
                                  groupValue: _groupValue3,
                                  activeColor: ColorConstant.primaryColor,
                                  onChanged: (value){
                                    setState(() {
                                      somethingSelected = true;
                                      _groupValue3 =3;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: RobotoText(
                                    value: "Faire une\n contre offre",
                                    fontSize: 14,
                                    maxLines: 3,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.gray,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
              somethingSelected? Container(
                height: 80,
                color: ColorConstant.primaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            somethingSelected =false;
                            _groupValue3 =0;
                          });
                        },
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
                    TextButton(
                      onPressed: () {
                        if(_groupValue3 ==3){
                          setState(() {
                            popUp = true;
                          });
                        }else{
                          dispatchEvent(_groupValue3);
                        }

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
              ):Container(),
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
                    height: 519,
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          child: CustomText(
                            value: "Objet : contre-offre relative à votre offre d’achat " ,
                            color: ColorConstant.darkText,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  value: "Prix",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: ColorConstant.darkText,
                                ),
                                SizedBox(height: 3,),
                                Container(
                                  child: TextFormField(
                                    initialValue: "",
                                    onChanged: (value){
                                      price = double.parse(value);
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontFamily: 'Multi',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13 ,
                                        color: ColorConstant.dark ,
                                        decoration: TextDecoration.none
                                    ),

                                    //   initialValue: initialValue,
                                    decoration: InputDecoration(
                                      fillColor: Color(0xFFF7F7F7),
                                      filled: true,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Multi',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13 ,
                                        color: Color(0xFF959595) ,
                                      ),
                                      contentPadding: const EdgeInsets.only(left: 20.0,top:12,bottom:12 ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFEEEEEE) ,

                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(5.0),),
                                      ),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFEEEEEE)
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(5.0),),
                                      ),
                                      border: InputBorder.none,
                                      suffixIconConstraints: BoxConstraints(minHeight: 26, minWidth: 26),
                                    ),

                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  value: "Date Limite",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: ColorConstant.darkText,
                                ),
                                SizedBox(height: 3,),
                                InkWell(
                                  onTap: _pickDate,
                                  child: Container(
                                    height: 48,
                                    width: 307,
                                    padding: EdgeInsets.only(left:20 ,right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Color(0xFFF7F7F7),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
                                          style: TextStyle(
                                            fontFamily: 'Multi',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14 ,
                                            color: ColorConstant.dark ,

                                          ),
                                        ),
                                        Icon(
                                          Icons.date_range_outlined,
                                          color: ColorConstant.suffixIcon,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              text: "Annuler",
                              fontWeight:FontWeight.w800,
                              fontSize: 11,
                              letterSpacing: 0.7,
                              height: 48,
                              onPressed: (){
                                setState(() {
                                  popUp =false;
                                });
                              },
                              minWidth: 135,
                            ),
                            GestureDetector(
                              onTap: (){
                                dispatchCounterOfferEvent(token,offer.id,price,limitDate,propertiesModel.id);
                                print(offer.id);
                              },
                              child: Material(
                                type: MaterialType.transparency,
                                child: CustomText(
                                  value: "Envoyer".toUpperCase(),
                                  color: ColorConstant.primaryColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
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
  String dateFromIsoString(String iso){
    var date = DateTime.parse(iso);
    return date.day.toString()+"/"+date.month.toString()+"/"+date.day.toString();
  }
  String timeFromIsoString(String iso){
    var date = DateTime.parse(iso);
    return date.hour.toString()+":"+date.minute.toString()+" PM";
  }
  void dispatchEvent(int index){
    print(index);
    switch(index){
      case 1 :dispatchAcceptOfferEvent(widget.token,widget.offer.id,widget.propertiesModel.id);
      break;
      case 2 :dispatchRejectOfferEvent(widget.token,widget.offer.id,widget.propertiesModel.id);
      break;
      case 3 :setState(() {
        popUp = true;
      });
      break;
    }
  }
  void _pickDate() async{
    String month;
    String day ;
    DateTime date = await showDatePicker(
      context: context,

      firstDate: DateTime(DateTime.now().year-100),
      lastDate: DateTime(DateTime.now().year+1),
      initialDate: DateTime.now(),
    );
    if(date!= null){
      if(date.month<10){
        month = "0${date.month}";
      }else{
        month = "${date.month}";
      }
      if(date.day<10){
        day = "0${date.day}";
      }else{
        day = "${date.day}";
      }
      setState(() {
        pickedDate =date;
        limitDate ="${date.year}-"+month+"-"+day;

      });
    }
  }
  void handleClick(String value) {
    switch (value) {
      case 'Envoyer un message pour l acheteur': dispatchGoToSendMessageEvent(widget.sender);
      break;
    }
  }
  void dispatchAcceptOfferEvent(String token,String idOffer,String idProp) {
    BlocProvider.of<OfferBloc>(context).add(AcceptOfferEvent(token: token, idOffer: idOffer,idProp: idProp));
  }
  void dispatchRejectOfferEvent(String token,String idOffer,String idProp) {
    BlocProvider.of<OfferBloc>(context).add(RejectOfferEvent(token: token, idOffer: idOffer,idProp:idProp ));
  }
  void dispatchCounterOfferEvent(String token,String idOffer,double price,String dateLimit,String idProp) {
    BlocProvider.of<OfferBloc>(context).add(CounterOfferEvent(token: token, idOffer: idOffer,price:price,dateLimit: dateLimit,idProp: idProp ));
  }
  void dispatchGoToOfferListEvent(String token,String id) {
    BlocProvider.of<OfferBloc>(context).add(GoToOfferListEvent(token: token,id: id));
  }
  void dispatchGoToSendMessageEvent(User sender) {
    BlocProvider.of<OfferBloc>(context).add(GoToSendMessageEvent(sender: sender));
  }
}
