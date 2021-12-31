import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBlueAppBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_bloc.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_event.dart';

class PackDisplay extends StatefulWidget {
  final Pack pack;
  final List<Pack>packs;
  const PackDisplay({Key key, this.pack,this.packs}) : super(key: key);
  @override
  _PackDisplayState createState() => _PackDisplayState();
}

class _PackDisplayState extends State<PackDisplay> {
  Color bax;
  Color border;
  Color text;
  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Pack pack =widget.pack;
    List<Pack> packs =widget.packs;
    return Scaffold(
      body: Column(
        children: [
          CustomBlueAppBar(
            title: "votre pack".toUpperCase(),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
                dispatchGoToPickPackEvent(packs);
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
                  Container(
                    height: 151,
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: bax,
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
                        border: Border.all(color: border,width: 3),
                        color: bax,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RobotoText(
                            value: "Pack "+pack.rang.toString()+" / € "+pack.amount.toString(),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            value: pack.desc1,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.white,
                          ),
                          CustomText(
                            value: pack.desc2,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    value: "Vous bénéficierez de",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: ColorConstant.darkText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(icon :Icon(Icons.done, color: Colors.green),),
                            CustomText(
                              value: "Format photo Horizontal & Vertical",
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
                              value: "Des photos avec lumière naturelle",
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
                              value: "Retouche les surfaces",
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
                              value: "Retouches avancés",
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
                              value: "Suppression les objets encombrants",
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
                              value: "Présentation en visite virtuelle",
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
                              value: "Une visite en drone",
                              color: ColorConstant.darkTextInfo,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
                    dispatchGoToPickDateEvent(packs,pack);
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
  void dispatchGoToPickDateEvent(List<Pack>packs,Pack pack) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickDateEvent(pack: pack,packs: packs));
  }
  void dispatchGoToPickPackEvent(List<Pack>packs) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickPackEvent(packs: packs));
  }
  String packName(int index){
    switch (index) {
      case 1: return "Pack 1 / € 250";
        break;
      case 2:return "Pack 2 / € 320";
        break;
      case 3:return "Pack 3 / € 450";
      break;
    }
  }
  void init(){
    switch(widget.pack.rang){
      case 1 :
        bax =Color(0xFF7DD3FC);
        border =Color(0xFF45BFF9);
        text = Color(0xFF12A1E5);
        break;
      case 2 :
        bax =Color(0xFFFF9ED5);
        border =Color(0xFFE177B3);
        text = Color(0xFFBC548F);
        break;
      case 3 :
        bax =Color(0xFF54D4B7);
        border =Color(0xFF2DBB9B);
        text = Color(0xFF2DA58A);
        break;
    }
  }
}
