import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/myproperties_view.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/properties_view.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';



class EstimationResult extends StatefulWidget {
   PropertiesModel propertiesModel;
  final List<double> estimationList;
  final String token;
   final List<PropertiesModel>listProp;
   final User user;

   EstimationResult({Key key, this.propertiesModel,this.estimationList,this.token,this.listProp,this.user}) : super(key: key);
  @override
  _EstimationResultState createState() => _EstimationResultState();
}

class _EstimationResultState extends State<EstimationResult> {
  int _groupValue = 1;
  double price;
  @override
  Widget build(BuildContext context) {
    List<double> estimationList = widget.estimationList;
    PropertiesModel propertiesModel =widget.propertiesModel;
    String token = widget.token;
    List<PropertiesModel>listProp =widget.listProp;
    User user =widget.user;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(token: token,listProp: listProp,user: user,),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20 ),
                    child: Row(
                      children: [
                        Radio(
                            value: 1,
                            groupValue: _groupValue,
                            activeColor: ColorConstant.primaryColor,
                            onChanged: (value){
                              setState(() {
                                _groupValue=1;
                              });

                            }
                        ),
                        Expanded(
                          child: Container(
                            height: 91,
                            decoration: BoxDecoration(
                              color:ColorConstant.minEstimationColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      RobotoText(
                                        value: "Prix Min",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.white,
                                      ),
                                      RobotoText(
                                        value: estimationList[0].round().toString()+" €",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: ColorConstant.white,
                                      ),
                                      RobotoText(
                                        value: "de 1100€ à 1222€ le m2",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SvgPicture.asset("Assets/Images/Intersection.svg"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20),
                    child: Row(
                      children: [
                        Radio(
                            value: 2,
                            groupValue: _groupValue,
                            activeColor: ColorConstant.primaryColor,
                            onChanged: (value){
                              setState(() {
                                _groupValue=2;
                              });

                            }
                        ),
                        Expanded(
                          child: Container(
                            height: 91,
                            decoration: BoxDecoration(
                              color:ColorConstant.moyEstimationColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      RobotoText(
                                        value: "Prix Moy",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.white,
                                      ),
                                      RobotoText(
                                        value: estimationList[1].round().toString()+" €",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: ColorConstant.white,
                                      ),
                                      RobotoText(
                                        value: "de 1100€ à 1222€ le m2",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SvgPicture.asset("Assets/Images/Intersection.svg",color: ColorConstant.moyEstimationIconColor,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Radio(
                            value: 3,
                            groupValue: _groupValue,
                            activeColor: ColorConstant.primaryColor,
                            onChanged: (value){
                              setState(() {
                                _groupValue=3;
                              });

                            }
                        ),
                        Expanded(
                          child: Container(
                            height: 91,
                            decoration: BoxDecoration(
                              color:ColorConstant.maxEstimationColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      RobotoText(
                                        value: "Prix Min",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.white,
                                      ),
                                      RobotoText(
                                        value: estimationList[2].round().toString()+" €",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: ColorConstant.white,
                                      ),
                                      RobotoText(
                                        value: "de 1100€ à 1222€ le m2",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SvgPicture.asset("Assets/Images/Intersection.svg",color: ColorConstant.maxEstimationIconColor,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: ColorConstant.estimationBackGroundColor,
                      child: Column(
                        children: [
                          Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                child: Divider(
                                  color: ColorConstant.black,
                                  thickness: 2,
                                  height: 2,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              CustomText(
                                value: "OU",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.black,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Container(
                                width: 25,
                                child: Divider(
                                  color: ColorConstant.black,
                                  thickness: 2,
                                  height: 2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Radio(
                                    value: 4,
                                    groupValue: _groupValue,
                                    activeColor: ColorConstant.primaryColor,
                                    onChanged: (value){
                                      setState(() {
                                        _groupValue=4;
                                      });

                                    }
                                ),
                                Expanded(
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color:ColorConstant.estimationColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                RobotoText(
                                                  value: "Mon prix souhaité",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorConstant.white,
                                                ),
                                                Container(
                                                  height: 37,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    onChanged: (value){
                                                      setState(() {
                                                        price = double.parse(value);
                                                      });
                                                    },
                                                    // keyboardType: textInputType,
                                                    style: TextStyle(
                                                        fontFamily: 'Multi',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14 ,
                                                        color: ColorConstant.dark ,
                                                        decoration: TextDecoration.none
                                                    ),

                                                    //   initialValue: initialValue,
                                                    decoration: InputDecoration(
                                                      fillColor: Color(0xFFF7F7F7),
                                                      filled: true,
                                                      hintText: "mon prix souhaité",
                                                      hintStyle: TextStyle(
                                                        fontFamily: 'Multi',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 13 ,
                                                        color: Color(0xFF959595) ,
                                                      ),
                                                      contentPadding: const EdgeInsets.only(left: 10.0,top:5,bottom:5 ),
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
                                                      border: InputBorder.none,
                                                    ),

                                                  ),
                                                ),
                                                RobotoText(
                                                  value: "Plus d'info",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant.white,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: SvgPicture.asset("Assets/Images/Intersection.svg",color: ColorConstant.blue,),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
                    child: CustomText(
                      value: "Des Biens dans la même cathégorie",
                      color: ColorConstant.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 360,
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PropertiesView(token: token,propertiesModel: listProp[index],);
                        },
                        itemCount: listProp.length,
                      ),
                    ),
                  ),
                  SizedBox(height:30 ,),
                  CustomButton(
                    text: "VALIDER LE PRIXS",
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    height: 48,
                    letterSpacing: 0.7,
                    onPressed: (){
                      propertiesModel.price = groupeValueToPrice(_groupValue,estimationList);
                      dispatchValidateEstimationEvent(propertiesModel,token);
                    },
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
  void dispatchValidateEstimationEvent(PropertiesModel propertiesModel,String token) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(ValidateEstimationEvent(propertiesModel: propertiesModel,token:token ));
  }
  double groupeValueToPrice(int value,List<double>listPrice){
    switch(value)  {
      case 1 :
        return listPrice[0];
      case 2 :
        return listPrice[1];
      case 3 :
        return listPrice[2];
      case 4 :
        return price ;

    }
  }
}
class Properties {
  String name;
  String image;
  String adresse;
  String surface ;
  String price;
  String date ;
  String time ;

  Properties({this.name, this.image, this.adresse, this.surface, this.price, this.date,
      this.time});

}
