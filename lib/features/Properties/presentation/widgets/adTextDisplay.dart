import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';

class AdTextDisplay extends StatefulWidget {
  final PropertiesModel propertiesModel;
  final String token;

  const AdTextDisplay({Key key, this.propertiesModel, this.token}) : super(key: key);
  @override
  _AdTextDisplayState createState() => _AdTextDisplayState();
}

class _AdTextDisplayState extends State<AdTextDisplay> {
  bool popUp = false;
  String description="";
  @override
  Widget build(BuildContext context) {
     PropertiesModel propertiesModel=widget.propertiesModel;
     String token=widget.token;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Ajouter un texte d'annonce".toUpperCase(),
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    //    dispatchGoHomeDisplayEvent();
                    print("ok");
                  },
                ),
              ),
              CustomBar(
                firstLine: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.round().toString()+" m²",
                secondLine: "10 rue AlbertMat - Virigneux 42140",
              ),

              Expanded(child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: CustomText(
                        value: "Proposer un texte d'annonce",
                        color: ColorConstant.darkText,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: TextField(
                          onChanged: (value){
                            setState(() {
                              description =value;
                            });
                          },
                          maxLines: 7 ,
                          //     expands: true,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                              fontFamily: 'Multi',
                              fontWeight: FontWeight.w400,
                              fontSize: 15 ,
                              color: ColorConstant.dark ,
                              decoration: TextDecoration.none
                          ),
                          decoration: InputDecoration(
                            fillColor: Color(0xFFEEEEEE),
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFEEEEEE) ,

                              ),
                              borderRadius: BorderRadius.all(const Radius.circular(10.0),),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFEEEEEE)
                              ),
                              borderRadius: BorderRadius.all(const Radius.circular(10.0),),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    CustomButton(
                      text: "Valider le bien".toUpperCase(),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      height: 48,
                      letterSpacing: 0.7,
                      onPressed: (){
                        setState(() {
                          popUp=true;
                        });
                      },
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              ))

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
                        SvgPicture.asset("Assets/Images/thumbsup.svg",),
                        Material(
                          type: MaterialType.transparency,
                          child: CustomText(
                            value: "Votre annonce n'est pas de suite\nactif et elle est en cours\nd'approbation …",
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            maxLines: 3,
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
                            propertiesModel.description = description;
                            dispatchGoToPropertieDisplayEvent(propertiesModel,token);
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
        ):Container()
      ],
    );
  }
  void dispatchGoToPropertieDisplayEvent(PropertiesModel propertiesModel,String token) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<PropertiesBloc>(context)
        .add(AddDescriptionEvent(propertiesModel: propertiesModel,token: token));
  }
}
