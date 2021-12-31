import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/calendarMonthBox.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customRadioButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/helpCalendarWidget.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_event.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class MonthDisponiblity extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  const MonthDisponiblity({Key key, this.user, this.token, this.listProp, this.propertiesModel, this.calendarMonth,this.calendar}) : super(key: key);

  @override
  _MonthDisponiblityState createState() => _MonthDisponiblityState();
}

class _MonthDisponiblityState extends State<MonthDisponiblity> {
  bool somethingSelected = false;
  bool choice1=false;
  bool choice2=false;
  bool choice3=false;
  bool choice4=false;
  bool choice5=false;
  bool choice6=false;
  bool choice7=false;
  int _groupeValue=0;
  List<CalendarMonth>freeMonths;
  CalendarMonth currentMonth;
  @override
  void initState() {
    currentMonth =widget.calendarMonth;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    FullCalendar calendar =widget.calendar;
    List<CalendarMonth>freeMonths=widget.calendar.freeMonths;
    return Scaffold(
      bottomNavigationBar: somethingSelected?null:CustomBottomNavBar(token: token,user: user,listProp: listProp,),
      body: Column(
        children: [
          CustomAppBar(
            title: "Créer mon agenda".toUpperCase(),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
                //    dispatchGoHomeDisplayEvent();
                print("ok");
              },
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                      child: CustomText(
                        color: ColorConstant.darkText,
                        value: "Votre disponibilité sur le mois de "+currentMonth.monthName,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  HelpCalendarWidget(text: "Sélectionnez les dates que vous aurez disponible pour :",),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CustomText(
                      color: ColorConstant.darkText,
                      value: "Vous serez disponible",
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButton(
                          text: "Après 18h sauf les Week end",
                          checked: choice1,
                          onTap: (){
                            setState(() {
                              choice1 =true;
                              choice2 =false;
                              choice3 =false;
                              choice4 =false;
                              choice5 =false;
                              choice6 =false;
                              choice7 = false;
                              somethingSelected =true;
                              _groupeValue =1;
                            });
                          },
                        ),
                        CustomRadioButton(
                          text: "Chaque samedi",
                          checked: choice2,
                          onTap: (){
                            setState(() {
                              choice1 =false;
                              choice2 =true;
                              choice3 =false;
                              choice4 =false;
                              choice5 =false;
                              choice6 =false;
                              choice7 = false;
                              somethingSelected =true;
                              _groupeValue =2;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButton(
                          text: "Chaque dimanche",
                          checked: choice3,
                          onTap: (){
                            setState(() {
                              choice1 =false;
                              choice2 =false;
                              choice3 =true;
                              choice4 =false;
                              choice5 =false;
                              choice6 =false;
                              choice7 = false;
                              somethingSelected =true;
                              _groupeValue =3;
                            });
                          },
                        ),
                        CustomRadioButton(
                          text: "Après 18h toute la semaine",
                          checked: choice4,
                          onTap: (){
                            setState(() {
                              choice1 =false;
                              choice2 =false;
                              choice3 =false;
                              choice4 =true;
                              choice5 =false;
                              choice6 =false;
                              choice7 = false;
                              somethingSelected =true;
                              _groupeValue =4;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButton(
                          text: "Après 18h tous les Week-end",
                          checked: choice5,
                          onTap: (){
                            setState(() {
                              choice1 =false;
                              choice2 =false;
                              choice3 =false;
                              choice4 =false;
                              choice5 =true;
                              choice6 =false;
                              choice7 = false;
                              somethingSelected =true;
                              _groupeValue =5;
                            });
                          },
                        ),
                        CustomRadioButton(
                          text: "Tous les week end",
                          checked: choice6,
                          onTap: (){
                            setState(() {
                              choice1 =false;
                              choice2 =false;
                              choice3 =false;
                              choice4 =false;
                              choice5 =false;
                              choice6 =true;
                              choice7 = false;
                              somethingSelected =true;
                              _groupeValue =6;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        choice1 =false;
                        choice2 =false;
                        choice3 =false;
                        choice4 =false;
                        choice5 =false;
                        choice6 =false;
                        choice7 = true;
                        somethingSelected =true;
                        _groupeValue =7;

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: choice7?ColorConstant.primaryColor: Color(0xFFE9ECF2) ,
                        ),
                        child: Center(
                          child: CustomText(
                            value:"Personnalisez votre disponibilité par jour",
                            color:choice7? ColorConstant.white: Color(0xFF272727),
                            fontSize:12,
                            fontWeight: FontWeight.w600,

                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CalendarMonthBox(
                          onTap: (){
                            if(freeMonths[0].month != currentMonth.month){
                              var m = CustomCalendar().getMonthFromYears(calendar.years,freeMonths[0].year,freeMonths[0].month);
                              if(m.selected){
                              }else{
                                setState(() {
                                  currentMonth = m;
                                });
                              }
                            }
                          },
                          thisMonth: (freeMonths[0].month == currentMonth.month),
                          monthName: freeMonths[0].monthName,
                          year: freeMonths[0].year,

                        ),
                        CalendarMonthBox(
                          onTap: (){
                            if(freeMonths[1].month != currentMonth.month){
                              var m = CustomCalendar().getMonthFromYears(calendar.years,freeMonths[1].year,freeMonths[1].month);
                              if(m.selected){
                                dispatchGoToConfirmedCalendarEvent(currentMonth,calendar);
                              }else{
                                setState(() {
                                  currentMonth = m;
                                });
                              }
                            }
                          },
                          thisMonth: (freeMonths[1].month == currentMonth.month),
                          monthName: freeMonths[1].monthName,
                          year: freeMonths[1].year,

                        ),
                        CalendarMonthBox(
                          onTap: (){
                            if(freeMonths[2].month != currentMonth.month){
                              var m = CustomCalendar().getMonthFromYears(calendar.years,freeMonths[2].year,freeMonths[2].month);
                              if(m.selected){
                                dispatchGoToConfirmedCalendarEvent(currentMonth,calendar);
                              }else{
                                setState(() {
                                  currentMonth = m;
                                });
                              }
                            }
                          },
                          thisMonth: (freeMonths[2].month == currentMonth.month),
                          monthName: freeMonths[2].monthName,
                          year: freeMonths[2].year,

                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40,)
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
                        choice1 =false;
                        choice2 =false;
                        choice3 =false;
                        choice4 =false;
                        choice5 =false;
                        choice6 =false;
                        choice7 = false;
                        somethingSelected =false;
                        _groupeValue =0;
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
                    if(!currentMonth.selected){
                      dispatchEvents( _groupeValue,currentMonth,calendar);
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
    );
  }
  void dispatchEvents(int _groupeValue , CalendarMonth calendarMonth,FullCalendar calendar){
    CustomCalendar().selectMonth(true, _groupeValue, calendarMonth, calendar.years);
    switch(_groupeValue){
      case 1 : dispatchGoToEvery18hWeekendEvent(calendarMonth,calendar);
        break;
      case 2 : dispatchGoToEveryWeekendEvent(calendarMonth,calendar); //saturday
      break;
      case 3 : dispatchGoToEveryWeekendEvent(calendarMonth,calendar); //sunday
      break;
      case 4 : dispatchGoToEvery18hWeekendEvent(calendarMonth,calendar);
      break;
      case 5 : dispatchGoToEvery18hWeekendEvent(calendarMonth,calendar);
      break;
      case 6 : dispatchGoToEveryWeekendEvent(calendarMonth,calendar); //everyweekend
      break;
      case 7 : dispatchGoToCustomDisponiblityEvent(calendarMonth,calendar);
      break;
    }

  }
  void dispatchGoToCustomDisponiblityEvent(CalendarMonth calendarMonth, FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToCustomDisponiblityEvent(calendarMonth: calendarMonth,calendar:calendar ));
  }
  void dispatchGoToEveryWeekendEvent(CalendarMonth calendarMonth, FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToEveryWeekendEvent(calendarMonth: calendarMonth,calendar:calendar ));
  }
  void dispatchGoToEvery18hWeekendEvent(CalendarMonth calendarMonth, FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToEvery18hWeekendEvent(calendarMonth: calendarMonth,calendar:calendar ));
  }
  void dispatchGoToConfirmedCalendarEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToConfirmedCalendarEvent(calendarMonth: calendarMonth,calendar: calendar));
  }

}
