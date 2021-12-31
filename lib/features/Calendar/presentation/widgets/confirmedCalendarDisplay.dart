import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/calendarMonthBox.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/helpCalendarWidget.dart';
import 'package:oikosmobile/core/Utils/sharedPref.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_event.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class ConfirmedCalendarDisplay extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;

  const ConfirmedCalendarDisplay({Key key, this.user, this.token, this.listProp, this.propertiesModel, this.calendarMonth, this.calendar}) : super(key: key);
  @override
  _ConfirmedCalendarDisplayState createState() => _ConfirmedCalendarDisplayState();
}

class _ConfirmedCalendarDisplayState extends State<ConfirmedCalendarDisplay> {
  final List<String> _weekDays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  List<FullCalendarDay> _daysThisMonth=[];
  final ScrollController _scrollController = ScrollController();
  int position=0;
  CalendarMonth currentMonth;
  @override
  void initState() {
    _daysThisMonth = getDaysThisMonth(widget.calendarMonth);
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
      bottomNavigationBar: CustomBottomNavBar(token: token,user: user,listProp: listProp,),
      body: Column(
        children: [
          CustomAppBar(
            title: "agenda".toUpperCase(),
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
                        value: "Dates et heures des RDV",
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: ColorConstant.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 420,
                        width: 314,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    if(position>0){
                                      setState(() {
                                        position --;
                                      });
                                      print(position);
                                      _animateToIndex(position);
                                    }
                                  },
                                  child: SvgPicture.asset("Assets/Images/previousBlue.svg",height: 18,width: 18,),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CustomText(
                                  value: currentMonth.monthName+" "+currentMonth.year.toString(),
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
                                      if(position<(_daysThisMonth.length/5)-1){
                                        position++;
                                      }
                                    });
                                    print(position);
                                    _animateToIndex(position);
                                  },
                                  child: SvgPicture.asset("Assets/Images/nextBlue.svg",height: 18,width: 18,),
                                )
                              ],
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
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: 364,
                                width: 294,
                                child: ListView.builder(
                                    controller: _scrollController,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _daysThisMonth.length,
                                    itemBuilder: (context,index){
                                      return Padding(
                                        padding: (index != _daysThisMonth.length-1)?
                                        const EdgeInsets.only(right: 6):EdgeInsets.only(right: 0),
                                        child: Container(
                                          width: 54,
                                          child: Column(
                                            children: [
                                              CustomText(
                                                value: reduceNames(_daysThisMonth[index].monthName),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF77838F),
                                              ),
                                              SizedBox(
                                                height: 9,
                                              ),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 2,color:Color(0xFFD8D8D8) ),
                                                  shape: BoxShape.circle,
                                                  // You can use like this way or like the below line
                                                  //borderRadius: new BorderRadius.circular(30.0),
                                                  color: ColorConstant.white,
                                                ),
                                                child: Center(
                                                  child: RobotoText(
                                                    value: _daysThisMonth[index].day.toString(),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF77838F),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 9,
                                              ),
                                              CustomText(
                                                value: reduceNames(_daysThisMonth[index].dayName),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF77838F),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 54,
                                                height: 262,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 3),
                                                  child: ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      padding: EdgeInsets.zero,
                                                      itemCount: _daysThisMonth[index].listTimes.length,
                                                      itemBuilder: (context,i){
                                                        return Padding(
                                                          padding: (i != _daysThisMonth[index].listTimes.length-1)?const EdgeInsets.only(bottom: 10)
                                                              :const EdgeInsets.only(bottom: 0),
                                                          child: _appointmentType(i, _daysThisMonth[index]),
                                                        );
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                        height: 420,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  CustomText(
                                    value: currentMonth.monthName+" "+currentMonth.year.toString(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF77838F),
                                  ),
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: SvgPicture.asset("Assets/Images/agendaIcon.svg"),
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
                            _calendarBody(currentMonth),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
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
                                setState(() {
                                  currentMonth = m;
                                  _daysThisMonth = getDaysThisMonth(currentMonth);
                                });
                              }else{
                                dispatchGoToMonthDisponiblityEvent(m,calendar);
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
                                setState(() {
                                  currentMonth = m;
                                  _daysThisMonth = getDaysThisMonth(currentMonth);
                                });
                              }else{
                                dispatchGoToMonthDisponiblityEvent(m,calendar);
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
                                setState(() {
                                  currentMonth = m;
                                  _daysThisMonth = getDaysThisMonth(currentMonth);
                                });
                              }else{
                                dispatchGoToMonthDisponiblityEvent(m,calendar);
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
                  SizedBox(
                    height: 40,
                  ),
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
                            diSelectMonth(currentMonth);
                            CustomCalendar().updateCalendarWithMonth(currentMonth, calendar.years);
                            dispatchGoToMonthDisponiblityEvent(currentMonth,calendar);
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
                            value:"Confirmer et renvoyer à la secrétaire".toUpperCase(),
                            color: ColorConstant.white,
                            fontSize:11,
                            fontWeight: FontWeight.w600,
                            letterSpacing:  0.7,
                          ),
                          onPressed: () async {
                            SharedPref sharedPref =SharedPref();
                            sharedPref.clear();
                            calendar.selected = true;
                            dispatchConfirmeCalendarEvent(calendar,token);
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
  Widget _calendarBody(CalendarMonth calendarMonth){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisCount: 7,
          crossAxisSpacing: 20,
        ),
        itemCount: calendarMonth.days.length+7,
        itemBuilder: (context,index){
          if(index < 7) return _weekDayTitle(index);
          return _calendarDates(calendarMonth.days[index - 7]);
        },
      ),
    );
  }
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
  Widget  _calendarDates(FullCalendarDay calendar){
    if(calendar.nextMonth || calendar.prevMonth){
      return Center(
        child: RobotoText(
          value: calendar.day.toString(),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE2E2E2),
        ),
      );
    }else{
      return calendar.selected?Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFC8F1C1)
        ),
        child: Center(
          child: RobotoText(
            value: calendar.day.toString(),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorConstant.primaryColor,
          ),
        ),
      ):Center(
        child: RobotoText(
          value: calendar.day.toString(),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFFAFB1B2),
        ),
      );
    }

  }
  Widget _dateDisplay(FullCalendarDay day){
    return Column(
      children: [
        CustomText(
          value: day.monthName,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color(0xFF77838F),
        ),
        SizedBox(
          height: 9,
        ),
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            border: Border.all(width: 2,color:Color(0xFFD8D8D8) ),
            shape: BoxShape.circle,
            // You can use like this way or like the below line
            //borderRadius: new BorderRadius.circular(30.0),
            color: ColorConstant.white,
          ),
          child: Center(
            child: RobotoText(
              value: day.day.toString(),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF77838F),
            ),
          ),
        ),
        SizedBox(
          height: 9,
        ),
        CustomText(
          value: day.dayName,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xFF77838F),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
  void dispatchGoToMonthDisponiblityEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToMonthDisponiblityEvent(calendarMonth: calendarMonth,calendar: calendar));
  }
  void diSelectMonth(CalendarMonth month){
    for(var day in month.days){
      if(day.thisMonth){
        day.selected = false;
        for(int i =0;i<day.listTimes.length;i++){
          day.listTimes[i].appointmentType = null;
          day.listTimes[i].selected = false;
        }
      }
    }
    for(int i =0;i<month.listTimes.length;i++){
      month.listTimes[i].selected = false;
      month.listTimes[i].appointmentType = null;
    }
    month.selected = false;
    month.index = -1;
  }
  List<FullCalendarDay> getDaysThisMonth(CalendarMonth month){
    List<FullCalendarDay> _listThis=[];
    for(var day in month.days){
      if(day.thisMonth){
        _listThis.add(day);
      }
    }
    return _listThis;
  }
  String reduceNames(String s){
    return s.substring(0, 3);
  }
  Widget _appointmentTypeNotAvailble(int index,FullCalendarDay day){
    return Container(
      width: 54,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFF2F2F2),
      ),
      child: Center(
        child: CustomText(
          value:day.listTimes[index].title,
          color:ColorConstant.white,
          fontSize: 7,
          fontWeight: FontWeight.w600,

        ),
      ),
    );
  }
  Widget _appointmentType(int index,FullCalendarDay day){
    return Container(
      width: 54,
      height: 20,
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
          fontSize: 7,
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
  _animateToIndex(i) => _scrollController.animateTo(300.0 * i, duration: Duration(microseconds: 1), curve: Curves.fastOutSlowIn);
  void handleClick(String value) {
    switch (value) {
      case 'Modifier': updateCurrentMonth();
      break;
      case 'Commander des services': print("Retouche automatisé");
      break;
    }
  }
  void updateCurrentMonth(){
    switch(currentMonth.index){
      case 1 : dispatchGoToEvery18hWeekendDayDisponibilityDisplayEvent(currentMonth,widget.calendar);
      break;
      case 2 : dispatchGoToEveryWeekendDayDisponibilityDisplayEvent(currentMonth,widget.calendar); //saturday
      break;
      case 3 : dispatchGoToEveryWeekendDayDisponibilityDisplayEvent(currentMonth,widget.calendar); //sunday
      break;
      case 4 : dispatchGoToEvery18hWeekendDayDisponibilityDisplayEvent(currentMonth,widget.calendar);
      break;
      case 5 : dispatchGoToEvery18hWeekendDayDisponibilityDisplayEvent(currentMonth,widget.calendar);
      break;
      case 6 : dispatchGoToEveryWeekendDayDisponibilityDisplayEvent(currentMonth,widget.calendar); //everyweekend
      break;
      case 7 : dispatchGoToCustomDisponiblityEvent(currentMonth,widget.calendar);
      break;
    }
  }
  void dispatchGoToConfirmedCalendarEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToConfirmedCalendarEvent(calendarMonth: calendarMonth,calendar: calendar));
  }
  void dispatchGoToEvery18hWeekendDayDisponibilityDisplayEvent(CalendarMonth date,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToEvery18hWeekendDayDisponibilityDisplayEvent(calendarMonth:date,calendar:calendar));
  }
  void dispatchGoToEveryWeekendDayDisponibilityDisplayEvent(CalendarMonth date,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToEveryWeekendDayDisponibilityDisplayEvent(calendarMonth:date,calendar:calendar));
  }
  void dispatchGoToCustomDisponiblityEvent(CalendarMonth calendarMonth, FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToCustomDisponiblityEvent(calendarMonth: calendarMonth,calendar:calendar ));
  }
  void dispatchConfirmeCalendarEvent(FullCalendar calendar, String token) {
    BlocProvider.of<CalendarBloc>(context)
        .add(ConfirmeCalendarEvent(token: token,calendar:calendar ));
  }
}
