import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/calendarMonthBox.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/helpCalendarWidget.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_event.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class CustomDiponibility extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;

  const CustomDiponibility({Key key, this.user, this.token, this.listProp, this.propertiesModel, this.calendarMonth,this.calendar}) : super(key: key);
  @override
  _CustomDiponibilityState createState() => _CustomDiponibilityState();
}

class _CustomDiponibilityState extends State<CustomDiponibility> {
  bool somethingSelected = false;
  List<FullCalendarDay> calendar;
  final List<String> _weekDays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  int indexSelected = -1;
  final ScrollController _scrollController1 = ScrollController();
  bool popUp = false;
  int groupValue = 1;
  CalendarMonth calendarMonth;
  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    FullCalendar fullCalendar =widget.calendar;
    List<CalendarMonth>freeMonths=widget.calendar.freeMonths;
    return Stack(
      children: [
        Scaffold(
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
                  controller: _scrollController1,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                          child: CustomText(
                            color: ColorConstant.darkText,
                            value: "Votre disponibilité sur le mois de "+calendarMonth.monthName,
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
                            height: 400,
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
                                        value: calendarMonth.monthName+" "+calendarMonth.year.toString(),
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
                                _calendarBody(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            somethingSelected =false;
                            indexSelected =-1;
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
                        setState(() {
                          if(calendar[indexSelected].selected){
                            dispatchGoToDayDisponiblityDisplayEvent(calendar[indexSelected].index, calendar[indexSelected], fullCalendar);
                          }else{
                            popUp = true;
                          }

                        });
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
        ),
        popUp? Stack(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  popUp = false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color:  ColorConstant.blueLoading,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    //  _loadPicker(ImageSource.gallery);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: 519,
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("Assets/Images/dateIcon.svg",),
                        Material(
                          type: MaterialType.transparency,
                          child: CustomText(
                            value: "RDV \n" +calendar[indexSelected].dayName+" / "+calendar[indexSelected].day.toString()+" "
                            +calendar[indexSelected].monthName+" "+calendar[indexSelected].year.toString(),
                            color: ColorConstant.darkText,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Column(
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              child: CustomText(
                                value: "Vous serez disponible entre",
                                color: ColorConstant.darkText,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 215,
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
                                  RobotoText(
                                    value: "09h et 12h",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.gray,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 215,
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
                                  RobotoText(
                                    value: "14h et 18h",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.gray,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 215,
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
                                  RobotoText(
                                    value: "09h et 12h / 14h et 18h",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.gray,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 215,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      value: 4,
                                      groupValue: groupValue,
                                      activeColor: ColorConstant.primaryColor,
                                      onChanged: (value){
                                        setState(() {
                                          groupValue =4;
                                        });
                                      }
                                  ),
                                  RobotoText(
                                    value: "Après 18h",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.gray,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              text: "Annuler",
                              fontWeight:FontWeight.w800,
                              fontSize: 11,
                              letterSpacing: 0.7,
                              height: 48,
                              onPressed: (){
                              setState(() {
                                popUp =false;
                              });
                              },
                              minWidth: 120,
                            ),
                            GestureDetector(
                              onTap: (){
                                  // day selected
                                  calendar[indexSelected].selected= true;
                                  dispatchGoToDisponiblityTimeEvent(groupValue,calendar[indexSelected],fullCalendar);

                              },
                              child: Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CustomText(
                                    value: "Choisir l'heure".toUpperCase(),
                                    color: ColorConstant.primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                  ),
                ),
              ),
            )
          ],
        ):Container()
      ],
    );
  }
  Widget _calendarBody(){
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
        itemCount: calendar.length+7,
        itemBuilder: (context,index){
          if(index < 7) return _weekDayTitle(index);
          return _calendarDates(index - 7);
        },
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
    if(calendar[index].nextMonth || calendar[index].prevMonth){
      return Center(
        child: RobotoText(
          value: calendar[index].day.toString(),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE2E2E2),
        ),
      );
    }else{
      return InkWell(
        onTap: (){
          setState(() {
            if(indexSelected == index){
              indexSelected =-1;
              somethingSelected =false;
            }else{
              indexSelected =index;
              somethingSelected =true;
              _scrollController1.jumpTo(_scrollController1.position.maxScrollExtent);
            }
          });
        },
        child: (indexSelected==index) ?Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstant.primaryColor
          ),
          child: Center(
            child: RobotoText(
              value: calendar[index].day.toString(),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorConstant.white,
            ),
          ),
        ):calendar[index].selected?Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFC8F1C1)
          ),
          child: Center(
            child: RobotoText(
              value: calendar[index].day.toString(),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorConstant.primaryColor,
            ),
          ),
        ):Center(
          child: RobotoText(
            value: calendar[index].day.toString(),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFFAFB1B2),
          ),
        ),
      );
    }

  }
  void init(){
    calendarMonth=widget.calendarMonth;
   calendar = CustomCalendar().getCalendarMonthFromYears(widget.calendar.years,widget.calendarMonth.year,widget.calendarMonth.month);
  }
  List<FullCalendarDay> getCalendarMonthFromYears(int year,int month){
    return CustomCalendar().getCalendarMonthFromYears(widget.calendar.years,year,month);
  }
  CalendarMonth getMonthFromYears(int year,int month){
    return CustomCalendar().getMonthFromYears(widget.calendar.years, year, month);
  }

  void dispatchGoToDisponiblityTimeEvent(int index ,FullCalendarDay date,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToDisponiblityTimeEvent(time: index,date: date,calendar:calendar));
  }
  void dispatchGoToDayDisponiblityDisplayEvent(int index ,FullCalendarDay date,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToDayDisponiblityDisplayEvent(time: index,date: date,calendar:calendar));
  }
}
