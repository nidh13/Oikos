import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBlueAppBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_bloc.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_event.dart';

class PickTimeDisplay extends StatefulWidget {
  final FullCalendarDay date ;
  final Pack pack;
  final List<Pack>packs;

  const PickTimeDisplay({Key key, this.date, this.pack, this.packs}) : super(key: key);
  @override
  _PickTimeDisplayState createState() => _PickTimeDisplayState();
}

class _PickTimeDisplayState extends State<PickTimeDisplay> {
  int indexSelected =-1;
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
    FullCalendarDay calendarDay=widget.date;
    Pack pack =widget.pack;
    List<Pack> packs =widget.packs;
    return Scaffold(
      body: Column(
        children: [
          CustomBlueAppBar(
            title: "heure du visite prestataire".toUpperCase(),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
                dispatchGoToPickDateEvent();
                print("ok");
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 40,),
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
                  value: "L'heure auquel vous la souhaitez pour le photoshoot",
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: ColorConstant.darkText,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: ColorConstant.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            value: calendarDay.dayName+" "+calendarDay.day.toString()+" "+calendarDay.monthName+" "+calendarDay.year.toString(),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF77838F),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFD8D8D8)
                          ),
                          SizedBox(
                            height: 40,
                          ),
                         _calendarBody(calendarDay),
                        ],
                      ),
                    ),
                  ),
                ),
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
                    dispatchGoToPickPropInformationEvent(calendarDay,calendarDay.listTimes[indexSelected].title);
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
  void dispatchGoToPickDateEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickDateEvent(pack: widget.pack,packs: widget.packs));
  }
  void dispatchGoToPickPropInformationEvent( FullCalendarDay date , String time) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickPropInformationEvent(time: time,date: date,packs: widget.packs,pack: widget.pack));
  }
  Widget _calendarBody(FullCalendarDay day){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (1 / .4),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: day.listTimes.length,
        itemBuilder: (context,index){
          return _calendarDates(index,day);
        },
      ),
    );
  }
  Widget _calendarDates(int index,FullCalendarDay day){
    return InkWell(
      onTap: (){
        setState(() {
          indexSelected = index;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 40,
            width: 100,
            decoration:
            BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFFE9ECF2),
              border: Border.all(color: Color(0xff4E4E4E), width: 1),
            ),
            child: Center(
              child: CustomText(
                value:day.listTimes[index].title,
                color:day.listTimes[index].selected ?ColorConstant.white:Color(0xFFB5B5B5),
                fontSize:13,
                fontWeight: FontWeight.w600,

              ),
            ),
          ),
          (index == indexSelected)?Positioned(
            right: -4,
            top: -8,
            child: Icon(
              Icons.check_circle,
              color: Color(0xff1EC501),
              size: 18,
            ),
          )
              :Positioned(
            right: -4,
            top: -8,
            child: SvgPicture.asset("Assets/Images/whiteCircle.svg",width: 15,height: 15,),
          )
        ],
      ),
    );
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
