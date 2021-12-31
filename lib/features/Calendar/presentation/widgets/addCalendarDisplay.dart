import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/core/Utils/helpCalendarWidget.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class AddCalendarDisplay extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;

  const AddCalendarDisplay({Key key, this.user, this.token, this.listProp,this.propertiesModel}) : super(key: key);
  @override
  _AddCalendarDisplayState createState() => _AddCalendarDisplayState();
}

class _AddCalendarDisplayState extends State<AddCalendarDisplay> {
  List<CalendarYear> years;
  List<FullCalendarDay> selectedDays=[];
  List<CalendarMonth>listMonths;
  int indexMonth =0;
  int position=0;
  bool somethingSelected = false;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController1 = ScrollController();
  @override
  void initState() {
    years =CustomCalendar().getCalendarBetweenTwoYears(DateTime.now().year, DateTime.now().year+10);
    // days =CustomCalendar().getAllDays(years);
    listMonths =CustomCalendar().getMonths(years);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    return Scaffold(
      bottomNavigationBar: selectedDays.isNotEmpty?null:CustomBottomNavBar(token: token,user: user,listProp: listProp,),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      if(indexMonth>0){
                                        indexMonth--;
                                        position=0;
                                        _animateToIndex(position);
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset("Assets/Images/previousBlue.svg",height: 18,width: 18,),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CustomText(
                                  value: listMonths[indexMonth].monthName+" "+listMonths[indexMonth].year.toString(),
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
                                      indexMonth++;
                                      position=0;
                                      _animateToIndex(position);
                                    });
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 52),
                                  child: InkWell(
                                    onTap: (){
                                      if(position>0){
                                        setState(() {
                                          position --;
                                        });
                                      }
                                      print(position);
                                      _animateToIndex(position);
                                    },
                                    child: SvgPicture.asset("Assets/Images/previousDay.svg",height: 18,width: 18,),
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: Container(
                                      //302
                                      width: 302,
                                      height: 274,
                                      child: ListView.builder(
                                          controller: _scrollController,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listMonths[indexMonth].days.length,
                                          itemBuilder: (context,index){
                                            return Padding(
                                              padding: (index != listMonths[indexMonth].days.length-1)?
                                              const EdgeInsets.only(right: 8):EdgeInsets.only(right: 0),
                                              child: Column(
                                                children: [
                                                  CustomText(
                                                    value: listMonths[indexMonth].days[index].monthName,
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
                                                        value: listMonths[indexMonth].days[index].day.toString(),
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
                                                    value: listMonths[indexMonth].days[index].dayName,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF77838F),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 54,
                                                    height: 172,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 3),
                                                      child: ListView.builder(
                                                          padding: EdgeInsets.zero,
                                                          itemCount: listMonths[indexMonth].days[index].listTimes.length,
                                                          itemBuilder: (context,i){
                                                            return Padding(
                                                              padding: (i != listMonths[indexMonth].days[index].listTimes.length-1)?const EdgeInsets.only(bottom: 10)
                                                                  :const EdgeInsets.only(bottom: 0),
                                                              child: InkWell(
                                                                onTap: (){
                                                                  setState(() {
                                                                    if(!listMonths[indexMonth].days[index].listTimes[i].selected){
                                                                      selectedDays.add(listMonths[indexMonth].days[index]);
                                                                    }else{
                                                                      selectedDays.remove(listMonths[indexMonth].days[index]);
                                                                    }
                                                                    listMonths[indexMonth].days[index].listTimes[i].selected =
                                                                    !listMonths[indexMonth].days[index].listTimes[i].selected;
                                                                    if(selectedDays.isNotEmpty){
                                                                      _scrollController1.jumpTo(_scrollController1.position.maxScrollExtent);
                                                                    }

                                                                  });
                                                                },
                                                                child: Stack(
                                                                  clipBehavior: Clip.none,
                                                                  // fit: StackFit.expand,
                                                                  children: [
                                                                    Container(
                                                                      width: 54,
                                                                      height: 20,
                                                                      decoration: listMonths[indexMonth].days[index].listTimes[i].selected ?BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Color(0xFFDCDCDC),
                                                                        border: Border.all(color: Color(0xff1EC501), width: 1),
                                                                      ):
                                                                      BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Color(0xFFF2F2F2),
                                                                      ),
                                                                      child: Center(
                                                                        child: CustomText(
                                                                          value: listMonths[indexMonth].days[index].listTimes[i].title,
                                                                          fontSize: 8,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: listMonths[indexMonth].days[index].listTimes[i].selected?Color(0xFFA2A2A2):Color(0xFFD5D5D5),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if(listMonths[indexMonth].days[index].listTimes[i].selected)Positioned(
                                                                      right: -4,
                                                                      top: -8,
                                                                      child: Icon(
                                                                        Icons.check_circle,
                                                                        color: Color(0xff1EC501),
                                                                        size: 15,
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
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 52),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(position<(listMonths[indexMonth].days.length/5)-1){
                                          position++;
                                        }
                                      });
                                      print(position);
                                      _animateToIndex(position);
                                    },
                                    child: SvgPicture.asset("Assets/Images/nextDay.svg",height: 18,width: 18,),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
         selectedDays.isNotEmpty? Container(
            height: 80,
            color: Color(0xff0060A2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {},
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
                   // if (path.length > 0) dispatchGoTOImageDisplayEvent(File(path),propertiesModel);
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
  _animateToIndex(i) => _scrollController.animateTo(310.0 * i, duration: Duration(microseconds: 1), curve: Curves.fastOutSlowIn);
}
