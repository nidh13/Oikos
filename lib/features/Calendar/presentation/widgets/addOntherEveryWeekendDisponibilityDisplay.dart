import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
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
class AddAnotherEveryWeekendDisponibilityDisplay extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;

  const AddAnotherEveryWeekendDisponibilityDisplay({Key key, this.user, this.token, this.listProp, this.propertiesModel, this.calendarMonth, this.calendar}) : super(key: key);
  @override
  _AddAnotherEveryWeekendDisponibilityDisplayState createState() => _AddAnotherEveryWeekendDisponibilityDisplayState();
}

class _AddAnotherEveryWeekendDisponibilityDisplayState extends State<AddAnotherEveryWeekendDisponibilityDisplay> {
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
    CalendarMonth calendarMonth =widget.calendarMonth;
     FullCalendar calendar=widget.calendar;
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
                            value: "RDV \n"+dayFormate(calendarMonth, indexSelected) ,
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
                              minWidth: 135,
                            ),
                            GestureDetector(
                              onTap: (){
                                calendarMonth.listTimes[indexSelected].selected =true;
                                selectType(calendarMonth,indexSelected);
                                CustomCalendar().updateCalendarWithMonth(calendarMonth, calendar.years);
                                dispatchGoToEveryWeekendDayDisponibilityDisplayEvent(calendarMonth,calendar);
                              },
                              child: Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
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
          if(month.listTimes[index].selected){
            return _calendarDatesSelected(index,month);
          }
          return _calendarDates(index,month);
        },
      ),
    );
  }
  Widget _calendarDatesSelected(int index,CalendarMonth month){
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
  Widget _calendarDates(int index,CalendarMonth month){
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
                value:month.listTimes[index].title,
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
  String dayFormate(CalendarMonth month,int index){
    return "Tout les week end"+" / "+month.monthName+" "+month.year.toString()+" / "+month.listTimes[index].title;

  }
  void selectType(CalendarMonth date,int index){
    switch(groupValue){
      case 1 : date.listTimes[index].appointmentType = AppointmentType.PHYSICAL;
      break;
      case 2 : date.listTimes[index].appointmentType = AppointmentType.VIRTUAL;
      break;
      case 3 : date.listTimes[index].appointmentType = AppointmentType.GROUP;
    }
    switch(date.index){
      case 2: for(var day in date.days){
        if(day.thisMonth&&(day.date.weekday == DateTime.saturday)){
          day.listTimes[index].appointmentType = date.listTimes[index].appointmentType;
          day.selected = true;
          day.listTimes[index].selected = true;
        }
      }
      break;
      case 3 : for(var day in date.days){
        if(day.thisMonth&&(day.date.weekday == DateTime.sunday)){
          day.listTimes[index].appointmentType = date.listTimes[index].appointmentType;
          day.selected = true;
          day.listTimes[index].selected = true;
        }
      }
      break;
      case 6 : for(var day in date.days){
        if(day.thisMonth&&(day.date.weekday == DateTime.sunday||day.date.weekday == DateTime.saturday)){
          day.listTimes[index].appointmentType = date.listTimes[index].appointmentType;
          day.selected = true;
          day.listTimes[index].selected = true;
        }
      }
      break;
    }
  }
  void dispatchGoToEveryWeekendDayDisponibilityDisplayEvent(CalendarMonth date,FullCalendar calendars) {
    BlocProvider.of<CalendarBloc>(context)
        .add(GoToEveryWeekendDayDisponibilityDisplayEvent(calendarMonth:date,calendar:calendars));
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
