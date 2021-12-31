import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class OffersListDisplay extends StatefulWidget {
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;
  final Offers offers ;
  final PropertiesModel propertiesModel;

  const OffersListDisplay({Key key, this.user, this.token, this.listProp, this.offers,this.propertiesModel}) : super(key: key);
  @override
  _OffersListDisplayState createState() => _OffersListDisplayState();
}

class _OffersListDisplayState extends State<OffersListDisplay> {
  List<Offer>listPending=[];
  @override
  void initState() {
    listPending = widget.offers.content.where((i) => (i.status == "PENDING")&& (i.recipientID ==widget.user.id)).toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    User user=widget.user;
    String token =widget.token;
    List<PropertiesModel>listProp=widget.listProp;
    Offers offers =widget.offers;

    PropertiesModel propertiesModel =widget.propertiesModel;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(token: token,user: user,listProp: listProp,),
      body: Column(
        children: [
          CustomAppBar(
            title: "Créer mon agenda".toUpperCase(),
          ),
          CustomBar(
            firstLine: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.round().toString()+" m²",
            secondLine: "10 rue AlbertMat - Virigneux 42140",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    value: listPending.length.toString()+" offers",
                    color: ColorConstant.black,
                    letterSpacing: 0.5,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                  Container(
                    height: 500,
                    child: ListView.builder(
                        itemCount: listPending.length,

                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: (){
                                dispatchGoToOfferDisplayEvent(token,listPending[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 10,
                                ),
                                height: 65,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEAF5FE),
                                  border: Border.all(
                                    color: Color(0xFFB4DCFF),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('Assets/Images/label.svg',color: Color(0xFF2699FB),height: 24,width: 20,),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CustomText(
                                      value: "Offer N° "+(index+1).toString()+"-A255",
                                      color: Color(0xFF2699FB),
                                      fontSize: 12,
                                      height: 1.25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void dispatchGoToOfferDisplayEvent(String token,Offer offer) {
    BlocProvider.of<OfferBloc>(context).add(GoToOfferDisplayEvent(token: token,offer: offer));
  }
}
