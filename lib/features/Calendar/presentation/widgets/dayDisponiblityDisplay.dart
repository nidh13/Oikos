import 'package:flutter/cupertino.dart';
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

class DayDisponiblityDisplay extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final FullCalendarDay date ;
  final int time;
  final FullCalendar calendar;

  const DayDisponiblityDisplay({Key key, this.user, this.token, this.listProp, this.propertiesModel, this.date, this.time,this.calendar}) : super(key: key);
  @override
  _DayDisponiblityDisplayState createState() => _DayDisponiblityDisplayState();
}

class _DayDisponiblityDisplayState extends State<DayDisponiblityDisplay> {
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    FullCalendarDay calendarDay=widget.date;
    int time =widget.time;
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
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CalendarMonthBox(
                          onTap: (){

                          },
                          thisMonth: (freeMonths[0].month == calendarDay.month),
                          monthName: freeMonths[0].monthName,
                          year: freeMonths[0].year,

                        ),
                        CalendarMonthBox(
                          onTap: (){

                          },
                          thisMonth: (freeMonths[1].month == calendarDay.month),
                          monthName: freeMonths[1].monthName,
                          year: freeMonths[1].year,

                        ),
                        CalendarMonthBox(
                          onTap: (){

                          },
                          thisMonth: (freeMonths[2].month == calendarDay.month),
                          monthName: freeMonths[2].monthName,
                          year: freeMonths[2].year,

                        )
                      ],
                    ),
                  ),
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
                            value:"Ajouter d'autres RDV".toUpperCase(),
                            color: ColorConstant.white,
                            fontSize:11,
                            fontWeight: FontWeight.w600,
                            letterSpacing:  0.7,
                          ),
                          onPressed: (){
                            print("ajout d'uatre");
                            if(SomthingAvailble(calendarDay,time)){
                              dispatchGoToAddOntherDayDisponiblityDisplayEvent(time, calendarDay,calendar);
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
                          color: Color(0xFFF078EC),
                          child: CustomText(
                            value:"Personnalisez d'autres RDV\nle reste de ce mois".toUpperCase(),
                            color: ColorConstant.white,
                            fontSize:11,
                            fontWeight: FontWeight.w600,
                            letterSpacing:  0.7,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: (){
                            print("Personnalisez d'autres RDV le reste de ce mois");
                         var m =   CustomCalendar().getMonthFromYears(calendar.years, calendarDay.year, calendarDay.month);
                            dispatchGoToCustomDisponiblityEvent(m,calendar);
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
                            diSelectDay(calendarDay);
                            CustomCalendar().updateCalendar(calendarDay, calendar.years);
                            var m =   CustomCalendar().getMonthFromYears(calendar.years, calendarDay.year, calendarDay.month);
                            m.selected = false;
                            m.index=-1;
                            CustomCalendar().updateCalendarWithMonth(m, calendar.years);
                            dispatchGoToMonthDisponiblityEvent(m,calendar);
                            print("Annuler et modifier ma disponibilité général");
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
                            var m =   CustomCalendar().getMonthFromYears(calendar.years, calendarDay.year, calendarDay.month);
                            dispatchGoToConfirmedCalendarEvent(m,calendar);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
          switch(widget.time){
            case 1:  if(index>2){
              return _calendarDatesNotAvailble(index,day);
            }
            break;
            case 2: if(index<3 || index>5){
              return _calendarDatesNotAvailble(index,day);
            }
            break;
            case 3 : if(index >5){
              return _calendarDatesNotAvailble(index,day);
            }
            break;
            case 4 : if(index<6){
              return _calendarDatesNotAvailble(index,day);
            }
            break;
          }
          return _calendarDates(index,day);
        },
      ),
    );
  }
  Widget _calendarDates(int index,FullCalendarDay day){
    return Container(
      height: 40,
      width: 100,
      decoration: day.listTimes[index].selected ?BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: appointmentTypeToColor(day.listTimes[index].appointmentType),
      ):
      BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFE9ECF2),
      ),
      child: Center(
        child: CustomText(
          value:day.listTimes[index].title,
          color:day.listTimes[index].selected ?ColorConstant.white:Color(0xFFB5B5B5),
          fontSize:13,
          fontWeight: FontWeight.w600,

        ),
      ),
    );
  }
  Widget _calendarDatesNotAvailble(int index,FullCalendarDay day){
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFF2F2F2),
      ),
      child: Center(
        child: CustomText(
          value:day.listTimes[index].title,
          color:ColorConstant.white,
          fontSize:13,
          fontWeight: FontWeight.w600,

        ),
      ),
    );
  }
  void handleClick(String value) {
    switch (value) {
      case 'Modifier': dispatchGoToUpdateDayDisponiblityDisplayEvent(widget.time, widget.date,widget.calendar);
        break;
      case 'Commander des services': print("Retouche automatisé");
      break;

    }
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
  void dispatchGoToUpdateDayDisponiblityDisplayEvent(int index ,FullCalendarDay date,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToUpdateDayDisponiblityDisplayEvent(time: index,date: date,calendar:calendar));
  }
  void dispatchGoToAddOntherDayDisponiblityDisplayEvent(int index ,FullCalendarDay date,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToAddOntherDayDisponiblityDisplayEvent(time: index,date: date,calendar:calendar));
  }
  void dispatchGoToCustomDisponiblityEvent(CalendarMonth calendarMonth, FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToCustomDisponiblityEvent(calendarMonth: calendarMonth,calendar:calendar ));
  }
  void dispatchGoToMonthDisponiblityEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToMonthDisponiblityEvent(calendarMonth: calendarMonth,calendar: calendar));
  }
  bool SomthingAvailble(FullCalendarDay day,int time){
    switch(widget.time){
      case 1:  for(int i=0;i<3;i++){
        if(!day.listTimes[i].selected){
          return true;
        }
      }
      break;
      case 2: for(int i=3;i<6;i++){
        if(!day.listTimes[i].selected){
          return true;
        }
      }
      break;
      case 3 : for(int i=0;i<6;i++){
        if(!day.listTimes[i].selected){
          return true;
        }
      }
      break;
      case 4 : for(int i=6;i<9;i++){
        if(!day.listTimes[i].selected){
          return true;
        }
      }
      break;
    }
    return false;
  }
  void diSelectDay(FullCalendarDay day){
    for(var t in day.listTimes){
      t.selected = false;
      t.appointmentType = null;
    }
    day.selected = false;
    day.index = -1;
  }
  void dispatchGoToConfirmedCalendarEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToConfirmedCalendarEvent(calendarMonth: calendarMonth,calendar: calendar));
  }
}
