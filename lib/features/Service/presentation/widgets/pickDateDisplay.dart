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

class PickDateServiceDisplay extends StatefulWidget {
  final Pack pack;
  final List<Pack>packs;

  const PickDateServiceDisplay({Key key, this.pack, this.packs}) : super(key: key);
  @override
  _PickDateServiceDisplayState createState() => _PickDateServiceDisplayState();
}

class _PickDateServiceDisplayState extends State<PickDateServiceDisplay> {
  Color bax;
  Color border;
  Color text;
  FullCalendarDay daySelected=FullCalendarDay();
  int currentIndex = 0;
  List<CalendarMonth> months ;
  final List<String> _weekDays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  @override
  void initState() {
    var years =CustomCalendar().getCalendarBetweenTwoYears(DateTime.now().year, DateTime.now().year+10);
    months = CustomCalendar().getALLMonthsFromYears(years);
    int index = DateTime.now().month-1;
    months.removeRange(0,index);
    daySelected = months[currentIndex].days[8];
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
            title: "Date du visite prestataire".toUpperCase(),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
                dispatchGoToPackDisplayEvent();
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
                    value: "La date auquel vous la souhaitez pour le photoshoot",
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
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(currentIndex>0){
                                          currentIndex--;
                                        }

                                      });
                                    },
                                    child: SvgPicture.asset("Assets/Images/previousBlue.svg",height: 18,width: 18,),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomText(
                                    value: months[currentIndex].monthName+" "+months[currentIndex].year.toString(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF77838F),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(currentIndex<months.length){
                                          currentIndex++;
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset("Assets/Images/nextBlue.svg",height: 18,width: 18,),
                                  )
                                ],
                              ),
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
                              height: 20,
                            ),
                            _calendarBody(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                    dispatchGoToPickTimeEvent(daySelected);
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
  void dispatchGoToPickTimeEvent(FullCalendarDay date) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickTimeEvent(date: date,packs: widget.packs,pack: widget.pack));
  }
  void dispatchGoToPackDisplayEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPackDisplayEvent(pack: widget.pack,packs: widget.packs));
  }
  Widget _calendarBody(){
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 20,
            crossAxisCount: 7,
            crossAxisSpacing: 20,
          ),
          itemCount: months[currentIndex].days.length+7,
          itemBuilder: (context,index){
            if(index < 7) return _weekDayTitle(index);
            return _calendarDates(index - 7);
          },
        ),
      ),
    );
  }
  // calendar header
  Widget _weekDayTitle(int index){
    return Center(
      child: CustomText(
        value: _weekDays[index],
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Color(0xFF77838F),
      ),
    );
  }
  Widget  _calendarDates(int index){
    if(months[currentIndex].days[index].nextMonth || months[currentIndex].days[index].prevMonth){
      return Center(
        child: RobotoText(
          value: months[currentIndex].days[index].day.toString(),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE2E2E2),
        ),
      );
    }else{
      return InkWell(
        onTap: (){
          setState(() {
            daySelected =months[currentIndex].days[index];
          });
        },
        child: (daySelected.day == months[currentIndex].days[index].day&&daySelected.month == months[currentIndex].days[index].month&&daySelected.year == months[currentIndex].days[index].year&&daySelected.thisMonth == months[currentIndex].days[index].thisMonth) ?Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstant.primaryColor
          ),
          child: Center(
            child: RobotoText(
              value: months[currentIndex].days[index].day.toString(),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorConstant.white,
            ),
          ),
        ):months[currentIndex].days[index].selected?Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFC8F1C1)
          ),
          child: Center(
            child: RobotoText(
              value: months[currentIndex].days[index].day.toString(),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorConstant.primaryColor,
            ),
          ),
        ):Center(
          child: RobotoText(
            value: months[currentIndex].days[index].day.toString(),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFFAFB1B2),
          ),
        ),
      );
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
