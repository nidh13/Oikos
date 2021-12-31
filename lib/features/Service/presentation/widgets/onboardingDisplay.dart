import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_bloc.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_event.dart';

class OnBoardingDisplay extends StatefulWidget {
  final List<Pack> packs;

  const OnBoardingDisplay({Key key, this.packs}) : super(key: key);
  @override
  _OnBoardingDisplayState createState() => _OnBoardingDisplayState();
}

class _OnBoardingDisplayState extends State<OnBoardingDisplay> {
  int state =0;
  @override
  Widget build(BuildContext context) {
    List<Pack> packs=widget.packs;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (state== 1)?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SvgPicture.asset(
                    'Assets/Images/locationImageService.svg',
                    height: 240,
                    width: 240,
                  ),
                ):(state== 2)?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SvgPicture.asset(
                    'Assets/Images/packSelect.svg',
                    height: 240,
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SvgPicture.asset(
                    'Assets/Images/pickDateService.svg',
                    height: 240,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  value: "Séance photo",
                  color: ColorConstant.darkText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 2.3,
                  letterSpacing: 0.1,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  value: (state== 1)?"Préciser le lieu du photoshoot":
                  (state== 2)?"Choisir votre pack":
                  "Sélectionner une date et une heure",
                  color: ColorConstant.darkText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 2.3,
                  letterSpacing: 0.1,
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: (state== 1)?ColorConstant.primaryColor:Color(0xFFA9E99E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: (state== 2)?ColorConstant.primaryColor:Color(0xFFA9E99E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: (state== 3)?ColorConstant.primaryColor:Color(0xFFA9E99E),
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                )
              ],
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
                        state=1;
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
                    setState(() {
                      if(state ==3){
                        dispatchGoToPickLocationEventt(packs);
                      }else{
                        state++;
                      }
                    });
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
  void dispatchGoToPickLocationEventt(List<Pack>packs) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickLocationEvent(packs: packs));
  }
}

