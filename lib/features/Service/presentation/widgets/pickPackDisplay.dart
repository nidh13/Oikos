import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBlueAppBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_bloc.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_event.dart';

class PickPackDisplay extends StatefulWidget {
  final List<Pack> packs;
  const PickPackDisplay({Key key, this.packs}) : super(key: key);
  @override
  _PickPackDisplayState createState() => _PickPackDisplayState();
}

class _PickPackDisplayState extends State<PickPackDisplay> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    List<Pack> packs=widget.packs;
    return Scaffold(
      body: Column(
        children: [
          CustomBlueAppBar(
            title: "Choisir votre pack".toUpperCase(),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
                dispatchGoToPickLocationEventt(packs);
                print("ok");
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: 1,
                            groupValue: groupValue,
                            activeColor: ColorConstant.primaryColor,
                            onChanged: (value){
                              setState(() {
                                groupValue =1;
                              });
                            }
                        ),
                        Container(
                          height: 151,
                          width: 300,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF7DD3FC),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Color.fromRGBO(0, 0, 0, 0.09),
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFF45BFF9),width: 3),
                                color: Color(0xFF7DD3FC),
                                ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RobotoText(
                                  value: "Pack 1 / € "+packs[0].amount.toString(),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF12A1E5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  value: packs[0].desc1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.white,
                                ),
                                CustomText(
                                  value: packs[0].desc2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: 2,
                            groupValue: groupValue,
                            activeColor: ColorConstant.primaryColor,
                            onChanged: (value){
                              setState(() {
                                groupValue =2;
                              });
                            }
                        ),
                        Container(
                          height: 151,
                          width: 300,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFF9ED5),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Color.fromRGBO(0, 0, 0, 0.09),
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFFE177B3),width: 3),
                              color: Color(0xFFFF9ED5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RobotoText(
                                  value: "Pack 2 / € "+packs[1].amount.toString(),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFBC548F),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  value: packs[1].desc1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.white,
                                ),
                                CustomText(
                                  value: packs[1].desc2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: 3,
                            groupValue: groupValue,
                            activeColor: ColorConstant.primaryColor,
                            onChanged: (value){
                              setState(() {
                                groupValue =3;
                              });
                            }
                        ),
                        Container(
                          height: 151,
                          width: 300,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF54D4B7),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Color.fromRGBO(0, 0, 0, 0.09),
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFF2DBB9B),width: 3),
                              color: Color(0xFF54D4B7),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RobotoText(
                                  value: "Pack 3 / € "+packs[2].amount.toString(),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2DA58A),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  value: packs[2].desc1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.white,
                                ),
                                CustomText(
                                  value: packs[2].desc2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            color: Color(0xFF5FAEE5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                      });
                    },
                    child: Text(
                      'Annuler'.toUpperCase(),
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
                    switch (groupValue) {
                      case 1: return dispatchGoToPackDisplayEvent(packs[0],packs);
                        break;
                      case 2: return dispatchGoToPackDisplayEvent(packs[1],packs);
                      break;
                      case 3: return dispatchGoToPackDisplayEvent(packs[2],packs);
                      break;
                    }
                  },
                  child: Text(
                    'Suivant'.toUpperCase(),
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
          )
        ],
      ),
    );
  }
  void dispatchGoToPackDisplayEvent(Pack pack,List<Pack>packs) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPackDisplayEvent(pack: pack,packs: packs));
  }
  void dispatchGoToPickLocationEventt(List<Pack>packs) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickLocationEvent(packs: packs));
  }
}
