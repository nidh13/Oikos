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

class AddOntherDayDisponibility extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final FullCalendarDay date ;
  final int time;
  final FullCalendar calendar;

  const AddOntherDayDisponibility({Key key, this.user, this.token, this.listProp, this.propertiesModel, this.date, this.time, this.calendar}) : super(key: key);
  @override
  _AddOntherDayDisponibilityState createState() => _AddOntherDayDisponibilityState();
}

class _AddOntherDayDisponibilityState extends State<AddOntherDayDisponibility> {
  List<CalendarMonth>freeMonths;
  bool somethingSelected = false;
  int indexSelected =-1;
  bool popUp = false;
  int groupValue = 1;
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
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar:somethingSelected?null:CustomBottomNavBar(token: token,user: user,listProp: listProp,),
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
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                          child: CustomText(
                            color: ColorConstant.darkText,
                            value: "Ajoutez un autre RDV",
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
                          popUp = true;
                        });
                      },
                      child: Text(
                        'ajouter'.toUpperCase(),
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
                            value: "RDV \n"+dayFormate(calendarDay, indexSelected) ,
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
                                value: "Vous souhaitez avoir ce RDV comme",
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
                                    value: "Visite physique",
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
                                    value: "Visite virtuelle",
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
                                    value: "Visite groupé",
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
                                  groupValue = 1;
                                  popUp =false;
                                });
                              },
                              minWidth: 120,
                            ),
                            GestureDetector(
                              onTap: (){
                                calendarDay.listTimes[indexSelected].selected =true;
                                selectType(calendarDay,indexSelected);
                                CustomCalendar().updateCalendar(calendarDay, calendar.years);
                                dispatchGoToDayDisponiblityDisplayEvent(time,calendarDay,calendar);
                              },
                              child: Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CustomText(
                                    value: "enregistrer".toUpperCase(),
                                    color: ColorConstant.primaryColor,
                                    fontSize: 11,
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
          if(day.listTimes[index].selected){
            return _calendarDatesSelected(index,day);
          }
          return _calendarDates(index,day);
        },
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
  Widget _calendarDatesSelected(int index,FullCalendarDay day){
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
  Widget _calendarDates(int index,FullCalendarDay day){
    return InkWell(
      onTap: (){
        setState(() {
          somethingSelected = true;
          indexSelected = index;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFFE9ECF2),
              border: Border.all(color: Color(0xff4E4E4E), width: 1),
            ),
            child: Center(
              child: CustomText(
                value:day.listTimes[index].title,
                color:Color(0xFFB5B5B5),
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
  String dayFormate(FullCalendarDay day,int index){
    return day.dayName+" / "+day.day.toString()+" "+day.monthName+" "+day.year.toString()+" / "+day.listTimes[index].title;

  }
  void selectType(FullCalendarDay date,int index){
    switch(groupValue){
      case 1 : date.listTimes[index].appointmentType = AppointmentType.PHYSICAL;
      break;
      case 2 : date.listTimes[index].appointmentType = AppointmentType.VIRTUAL;
      break;
      case 3 : date.listTimes[index].appointmentType = AppointmentType.GROUP;
    }
  }
  void dispatchGoToDayDisponiblityDisplayEvent(int index ,FullCalendarDay date,FullCalendar calendar) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToDayDisponiblityDisplayEvent(time: index,date: date,calendar:calendar));
  }
}

