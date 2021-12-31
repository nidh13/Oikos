import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/calendarMonthBox.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/helpCalendarWidget.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_event.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class EveryWeekendDisponibilityDisplay extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;

  const EveryWeekendDisponibilityDisplay({Key key, this.user, this.token, this.listProp, this.propertiesModel, this.calendarMonth, this.calendar}) : super(key: key);
  @override
  _EveryWeekendDisponibilityDisplayState createState() => _EveryWeekendDisponibilityDisplayState();
}

class _EveryWeekendDisponibilityDisplayState extends State<EveryWeekendDisponibilityDisplay> {
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    CalendarMonth calendarMonth =widget.calendarMonth;
    FullCalendar calendar =widget.calendar;
    List<CalendarMonth>freeMonths=widget.calendar.freeMonths;
    return Scaffold(
      bottomNavigationBar:CustomBottomNavBar(token: token,user: user,listProp: listProp,),
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
            action: PopupMenuButton<String>(
              // padding: EdgeInsets.only(right: 5),
              icon: SvgPicture.asset("Assets/Images/menudotsverticalIcon.svg",height: 20,width: 20,),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Modifier', 'Commander des services'}.map((String choice) {
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
            firstLine: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.toString()+" m²",
            secondLine: "10 rue AlbertMat - Virigneux 42140",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                      child: CustomText(
                        color: ColorConstant.darkText,
                        value: "Choisissez votre disponibilité en sélectionnant l'heure",
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              value: calendarMonth.monthName+" "+calendarMonth.year.toString()+"\n"+textDisplay(calendarMonth),
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
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
                            _calendarBody(calendarMonth),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CalendarMonthBox(
                          onTap: (){

                          },
                          thisMonth: (freeMonths[0].month == calendarMonth.month),
                          monthName: freeMonths[0].monthName,
                          year: freeMonths[0].year,

                        ),
                        CalendarMonthBox(
                          onTap: (){

                          },
                          thisMonth: (freeMonths[1].month == calendarMonth.month),
                          monthName: freeMonths[1].monthName,
                          year: freeMonths[1].year,

                        ),
                        CalendarMonthBox(
                          onTap: (){

                          },
                          thisMonth: (freeMonths[2].month == calendarMonth.month),
                          monthName: freeMonths[2].monthName,
                          year: freeMonths[2].year,

                        )
                      ],
                    ),
                  ),*/
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30 ),
                    child: Container(
                      width: double.infinity,
                      child: ButtonTheme(
                        height: 55,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: RaisedButton(
                          color: Color(0xFFF0B078),
                          child: CustomText(
                            value:"Ajouter d'autres RDV\nTout les week end".toUpperCase(),
                            color: ColorConstant.white,
                            fontSize:11,
                            fontWeight: FontWeight.w600,
                            letterSpacing:  0.7,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: (){
                            print("ajout d'uatre");
                            if(SomthingAvailble(calendarMonth)){
                              dispatchGoToAddAnotherEveryWeekendDayDisponibilityDisplayEvent(calendarMonth,calendar);
                            }else{
                              print("full");
                            }

                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30 ),
                    child: Container(
                      width: double.infinity,
                      child: ButtonTheme(
                        height: 55,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: RaisedButton(
                          color: Color(0xFF5FAEE5),
                          child: CustomText(
                            value:"Annuler et modifie\nma disponibilité général".toUpperCase(),
                            color: ColorConstant.white,
                            fontSize:11,
                            fontWeight: FontWeight.w600,
                            letterSpacing:  0.7,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: (){
                            diSelectMonth(calendarMonth);
                            CustomCalendar().updateCalendarWithMonth(calendarMonth, calendar.years);
                            dispatchGoToMonthDisponiblityEvent(calendarMonth,calendar);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30 ),
                    child: Container(
                      width: double.infinity,
                      child: ButtonTheme(
                        height: 55,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: RaisedButton(
                          color: ColorConstant.primaryColor,
                          child: CustomText(
                            value:"confirmer mon agenda".toUpperCase(),
                            color: ColorConstant.white,
                            fontSize:11,
                            fontWeight: FontWeight.w600,
                            letterSpacing:  0.7,
                          ),
                          onPressed: (){
                            dispatchGoToConfirmedCalendarEvent(calendarMonth,calendar);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void handleClick(String value) {
    switch (value) {
      case 'Modifier': dispatchGoToUpdateEveryWeekendDayDisponibilityDisplayEvent(widget.calendarMonth,widget.calendar);
      break;
      case 'Commander des services': print("Retouche automatisé");
      break;
    }
  }
  Widget _calendarBody(CalendarMonth month){
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
        itemCount: month.listTimes.length,
        itemBuilder: (context,index){
          return _calendarDates(index,month);
        },
      ),
    );
  }
  Widget _calendarDates(int index,CalendarMonth month){
    return Container(
      height: 40,
      width: 100,
      decoration: month.listTimes[index].selected ?BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: appointmentTypeToColor(month.listTimes[index].appointmentType),
      ):
      BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFE9ECF2),
      ),
      child: Center(
        child: CustomText(
          value:month.listTimes[index].title,
          color:month.listTimes[index].selected ?ColorConstant.white:Color(0xFFB5B5B5),
          fontSize:13,
          fontWeight: FontWeight.w600,

        ),
      ),
    );
  }
  Color appointmentTypeToColor(AppointmentType appointmentType){
    switch(appointmentType){
      case AppointmentType.PHYSICAL : return ColorConstant.maxEstimationColor;
      break;
      case AppointmentType.VIRTUAL : return ColorConstant.primaryColor;
      break;
      case AppointmentType.GROUP : return ColorConstant.blue;
      break;
    }
  }
  void dispatchGoToUpdateEveryWeekendDayDisponibilityDisplayEvent(CalendarMonth month,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToUpdateEveryWeekendDayDisponibilityDisplayEvent(calendarMonth:month,calendar:calendar));
  }
  void dispatchGoToAddAnotherEveryWeekendDayDisponibilityDisplayEvent(CalendarMonth month,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToAddAnotherEveryWeekendDayDisponibilityDisplayEvent(calendarMonth:month,calendar:calendar));
  }
  void dispatchGoToMonthDisponiblityEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToMonthDisponiblityEvent(calendarMonth: calendarMonth,calendar: calendar));
  }
  void dispatchGoToConfirmedCalendarEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToConfirmedCalendarEvent(calendarMonth: calendarMonth,calendar: calendar));
  }
  void diSelectMonth(CalendarMonth month){
    switch(month.index){
      case 2: for(var day in month.days){
        if(day.thisMonth&&(day.date.weekday == DateTime.saturday)){
          day.selected = false;
          for(var time in day.listTimes){
            time.appointmentType = null;
            time.selected = false;
          }
        }
      }
      break;
      case 3 :for(var day in month.days){
        if(day.thisMonth&&(day.date.weekday == DateTime.sunday)){
          day.selected = false;
          for(var time in day.listTimes){
            time.appointmentType = null;
            time.selected = false;
          }
        }
      }
      break;
      case 6 : for(var day in month.days){
        if(day.thisMonth&&(day.date.weekday == DateTime.sunday||day.date.weekday == DateTime.saturday)){
          day.selected = false;
          for(var time in day.listTimes){
            time.appointmentType = null;
            time.selected = false;
          }
        }
      }
      break;
    }
    for(var t in month.listTimes){
      t.selected = false;
      t.appointmentType = null;
    }
    month.selected = false;
    month.index = -1;
  }
  bool SomthingAvailble(CalendarMonth month){
    for(int i= 0;i<month.listTimes.length;i++){
      if(!month.listTimes[i].selected){
        return true;
      }
    }
    return false;
  }
  String textDisplay(CalendarMonth month){
    switch(month.index){
      case 2: return "Chaque Samedi";
      break;
      case 3 : return "Chaque Dimanche";
      break;
      case 6 : return "Tout les week end";
      break;
    }
  }
}
