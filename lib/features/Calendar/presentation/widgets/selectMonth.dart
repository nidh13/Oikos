import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customMonthButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/helpCalendarWidget.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class SelectMonth extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final FullCalendar calendar;

  const SelectMonth({Key key, this.user, this.token, this.listProp, this.propertiesModel,this.calendar}) : super(key: key);
  @override
  _SelectMonthState createState() => _SelectMonthState();
}

class _SelectMonthState extends State<SelectMonth> {
  FullCalendar calendar= FullCalendar();
  int indexYear = 0;
  bool somethingSelected = false;
  CalendarMonth selectedMonth;
  @override
  void initState() {
    if(widget.calendar!= null){
      calendar = widget.calendar;
      print ("jawou behi");
    }else{

      print("wslet lena");
      var years =CustomCalendar().getCalendarBetweenTwoYears(DateTime.now().year, DateTime.now().year+10);
      calendar.years =years;
      print(calendar.years.length);
      calendar.freeMonths = CustomCalendar().getFreeMonths(calendar.years);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    final ScrollController _scrollController1 = ScrollController();
    void checkMonth(int index){
      for(int i=0;i<calendar.years[indexYear].months.length;i++){
        if(i==index ){
          calendar.years[indexYear].months[i].checked =true ;
          somethingSelected = true;
          selectedMonth = calendar.years[indexYear].months[i];
          _scrollController1.jumpTo(_scrollController1.position.maxScrollExtent);
        }else{
          calendar.years[indexYear].months[i].checked =false;
        }
      }
    }
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
              controller: _scrollController1,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                      child: CustomText(
                        color: ColorConstant.darkText,
                        value: "Choisissez votre disponibilité en sélectionnant les dates",
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  HelpCalendarWidget(text: "Sélectionnez les dates que vous aurez disponible pour :",),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                    child: Card(
                      color: ColorConstant.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 377,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(indexYear>0){
                                        indexYear --;
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset("Assets/Images/previousDark.svg",height: 18,width: 18,),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CustomText(
                                  value: "Agenda "+calendar.years[indexYear].year.toString(),
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
                                      if(indexYear<calendar.years.length-1){
                                        indexYear++;
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset("Assets/Images/nextDark.svg",height: 18,width: 18,),
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
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[0].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[0].available){
                                        checkMonth(0);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[0].checked,
                                  available: calendar.years[indexYear].months[0].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[1].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[1].available){
                                        checkMonth(1);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[1].checked,
                                  available: calendar.years[indexYear].months[1].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[2].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[2].available){
                                        checkMonth(2);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[2].checked,
                                  available: calendar.years[indexYear].months[2].available,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[3].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[3].available){
                                        checkMonth(3);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[3].checked,
                                  available: calendar.years[indexYear].months[3].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[4].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[4].available){
                                        checkMonth(4);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[4].checked,
                                  available: calendar.years[indexYear].months[4].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[5].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[5].available){
                                        checkMonth(5);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[5].checked,
                                  available: calendar.years[indexYear].months[5].available,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[6].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[6].available){
                                        checkMonth(6);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[6].checked,
                                  available: calendar.years[indexYear].months[6].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[7].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[7].available){
                                        checkMonth(7);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[7].checked,
                                  available: calendar.years[indexYear].months[7].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[8].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[8].available){
                                        checkMonth(8);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[8].checked,
                                  available: calendar.years[indexYear].months[8].available,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[9].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[9].available){
                                        checkMonth(9);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[9].checked,
                                  available: calendar.years[indexYear].months[9].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[10].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[10].available){
                                        checkMonth(10);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[10].checked,
                                  available: calendar.years[indexYear].months[10].available,
                                ),
                                CustomMonthButton(
                                  text: calendar.years[indexYear].months[11].monthName,
                                  onTap: (){
                                    setState(() {
                                      if(calendar.years[indexYear].months[11].available){
                                        checkMonth(11);
                                      }

                                    });
                                  },
                                  checked: calendar.years[indexYear].months[11].checked,
                                  available: calendar.years[indexYear].months[11].available,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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
                        somethingSelected = false;
                        selectedMonth =null;
                        for(var year in calendar.years){
                          for(int i=0;i<year.months.length;i++){
                            year.months[i].checked =false;
                          }
                        }
                        indexYear = 0;
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
                  var m =  CustomCalendar().getMonthFromYears(calendar.years, selectedMonth.year, selectedMonth.month);
                    dispatchGoToMonthDisponiblityEvent(m,calendar);
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
  void dispatchGoToMonthDisponiblityEvent(CalendarMonth calendarMonth,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToMonthDisponiblityEvent(calendarMonth: calendarMonth,calendar: calendar));
  }
}
