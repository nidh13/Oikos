import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/customText.dart';

class CalendarMonthBox extends StatelessWidget {
  final bool thisMonth;
  final Function onTap;
  final String monthName;
  final int year;

  const CalendarMonthBox({Key key, this.thisMonth, this.onTap, this.monthName, this.year}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        color: thisMonth?Color(0xFFB5B5B5):Color(0xFFF2F2F2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                color: thisMonth?Colors.white:Color(0xFFB5B5B5),
                value: "Votre disponibilité\nsur le mois",
                fontSize: 10,
                fontWeight: FontWeight.w600,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  thisMonth?SvgPicture.asset("Assets/Images/whiteCalendarBox.svg",):SvgPicture.asset("Assets/Images/calendarBox.svg",),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomText(
                      color: thisMonth?Colors.white:Color(0xFFB5B5B5),
                      value: monthName+"\n"+year.toString(),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
