import 'package:intl/intl.dart';
import 'package:oikosmobile/features/Calendar/domain/entities/disponibility_model.dart';

class CustomCalendar{

  // number of days in month [JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC]
  final List<int> _monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  // check for leap year
  bool _isLeapYear(int year){
    if(year % 4 == 0){
      if(year % 100 == 0){
        if(year % 400 == 0) return true;
        return false;
      }
      return true;
    }
    return false;
  }

  /// get the month calendar
  /// month is between from 1-12 (1 for January and 12 for December)
  List<FullCalendarDay> getFullMonthCalendar(int month, int year,){
// used for previous and next month's calendar days
    int otherYear;
    int otherMonth;
    int leftDays;
    // validate
    if(year == null || month == null || month < 1 || month > 12)
      throw ArgumentError('Invalid year or month');
    List<FullCalendarDay> calendar = <FullCalendarDay>[];
    // get no. of days in the month
    // month-1 because _monthDays starts from index 0
    // and month starts from 1
    int totalDays = _monthDays[month - 1];
    // if this is a leap year and the month is february,
    // increment the total days by 1
    if(_isLeapYear(year) && month == DateTime.february) totalDays++;
    // get days for this month
    for(int i=0; i<totalDays; i++){
      calendar.add(
        FullCalendarDay(
          // i+1 because day starts from 1 in DateTime class
          date: DateTime(year, month, i+1),
          thisMonth: true,
            prevMonth: false,
            nextMonth: false,
            dayName: engDayToFr(DateFormat('EEEE').format(DateTime(year, month, i+1))),
            day: i+1,
            monthName: getMonthName(month),
            month: month,
            year: year,
          selected: false,
          index: -1
        ),
      );
    }
    // fill the unfilled starting weekdays of this month with the previous month days
    if(calendar.first.date.weekday != DateTime.monday){
      // if this month is january, then previous month would be decemeber of previous year
      if(month == DateTime.january){
        otherMonth = DateTime.december; // _monthDays index starts from 0 (11 for december)
        otherYear = year-1;
      }
      else{
        otherMonth = month - 1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0 and month starts from 1
      //31
      totalDays = _monthDays[otherMonth - 1];
      if(_isLeapYear(otherYear) && otherMonth == DateTime.february) totalDays++;
      //31-3+1=29
      leftDays = totalDays - calendar.first.date.weekday + 1;
//31 >29
      for(int i=totalDays; i>leftDays; i--){
        calendar.insert(0,
          FullCalendarDay(
            date: DateTime(otherYear, otherMonth, i),
            prevMonth: true,
              nextMonth: false,
              thisMonth: false,
              dayName: engDayToFr(DateFormat('EEEE').format(DateTime(otherYear, otherMonth, i+1))),
              day: i+1,
              monthName: getMonthName(otherMonth),
              month: otherMonth,
              year: otherYear,
            selected: false
          ),
        );
      }
    }
    // fill the unfilled ending weekdays of this month
// with the next month days
    if(calendar.last.date.weekday != DateTime.sunday){
      // if this month is december,
      // then next month would be january of next year
      if(month == DateTime.december){
        otherMonth = DateTime.january;
        otherYear = year+1;
      }
      else{
        otherMonth = month+1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0
      // and month starts from 1
      //31
      totalDays = _monthDays[otherMonth-1];
      if(_isLeapYear(otherYear) && otherMonth == DateTime.february)
        totalDays++;
      //7-4=3
      leftDays = 7 - calendar.last.date.weekday;
      if(leftDays == -1) leftDays = 6;
      for(int i=0; i<leftDays; i++){
        calendar.add(
          FullCalendarDay(
            date: DateTime(otherYear, otherMonth, i+1),
            nextMonth: true,
              prevMonth: false,
              thisMonth: false,
              dayName: engDayToFr(DateFormat('EEEE').format(DateTime(otherYear, otherMonth, i+1))),
              day: i+1,
              monthName: getMonthName(otherMonth),
              month: otherMonth,
              year: otherYear,
            selected: false
          ),
        );
      }
    }
    return calendar;
  }
  List<CalendarMonth>getYearCalendar(int year){
    List<CalendarMonth> months= List<CalendarMonth>();
    for(int i =1;i<13;i++){
      months.add(
          CalendarMonth(
            month: i,
            year: year,
          monthName: getMonthName(i),
          days:  getFullMonthCalendar(i, year),
            available: false,
            checked: false,
            selected: false,
            index: -1,
        )
      );
    }
    return months;
  }
  List<FullCalendarDay> getCalendarMonthFromYears(List<CalendarYear> years,int year,int month){
    for(var y in years){
      if (y.year ==year){
        for(var m in y.months){
          if(m.month == month){
            return m.days;
          }
        }
      }
    }
  }
  CalendarMonth getMonthFromYears(List<CalendarYear> years,int year,int month){
    for(var y in years){
      if (y.year==year){
        for(var m in y.months){
          if(m.month == month){
            return m;
          }
        }
      }
    }
  }
  List<CalendarMonth> getALLMonthsFromYears(List<CalendarYear> years){
     List<CalendarMonth> all=[];
    for(var y in years){
     for(var m in y.months){
       all.add(m);
     }
    }
     all.removeWhere((m) => (m.month<DateTime.now().month)&& (m.month ==DateTime.now().year));
    return all;
  }

  List<CalendarYear>getCalendarBetweenTwoYears(int firstYear , int lastYear){
    List<CalendarYear> years= List<CalendarYear>();
    for (int i=firstYear;i<lastYear+1;i++){
      years.add(
          CalendarYear(
          months: getYearCalendar(i),
            year: i,
        )
      );

    }
    setFreeMonths(years);
   // return months;
    return years;
  }
  void updateCalendar(FullCalendarDay day ,List<CalendarYear> years){
   for (var year in years){
     if(year.year == day.year){
       for(var month in year.months){
         if(month.month == day.month){
           for(var d in month.days){
             if(day.thisMonth&&(d.day==day.day)){
               d=day;
             }
           }
         }
       }
     }
   }
  }
  void updateCalendarWithMonth(CalendarMonth month ,List<CalendarYear> years){
    for (var year in years){
      if(year.year == month.year){
        for(var m in year.months){
          if(m.month == month.month){
            m =month;
          }
        }
      }
    }
  }
  void selectMonth(bool select,int index,CalendarMonth month,List<CalendarYear>years){
    for(var year in years){
      if(year.year == month.year){
        for(var m in year.months){
          if(m.month == month.month){
            month.selected =select;
            month.index =index;
            m.selected =select;
            m.index = index;
          }
        }
      }
    }
  }
  void setFreeMonths(List<CalendarYear> calendarYear){
    int firstMonth = DateTime.now().month-1;
    if(firstMonth == 10){
      calendarYear[0].months[firstMonth].available =true;
      calendarYear[0].months[firstMonth+1].available =true;
      calendarYear[1].months[0].available =true;
    }else if(firstMonth ==11){
      calendarYear[0].months[firstMonth].available =true;
      calendarYear[1].months[0].available =true;
      calendarYear[1].months[1].available =true;
    }else{
      calendarYear[0].months[firstMonth].available =true;
      calendarYear[0].months[firstMonth+1].available =true;
      calendarYear[0].months[firstMonth+2].available =true;
    }
  }
  List<CalendarMonth>getFreeMonths(List<CalendarYear> calendarYear){
    List<CalendarMonth> months=[];
    for(var year in calendarYear){
      for(var month in year.months){
        if(month.available){
          months.add(month);
        }
      }
    }
    return months;
  }
  List<Disponibility>getAllDisponibility(FullCalendar calendar)  {
    List<Disponibility> list =[];
    for (var year in calendar.years){
      for(var month in year.months){
        if(month.selected){
          for(var day in month.days){
            if(day.selected&&day.thisMonth){
              var l =  dayToDisponiblity(day);
              list =list+l;
            }
          }
        }
      }
    }
    return list;
  }
  List<Disponibility> dayToDisponiblity(FullCalendarDay day){
    List<Disponibility> dislist =[];
    for(int i=0;i<day.listTimes.length;i++){
      if(day.listTimes[i].selected){
        var dateStart = new DateTime(
            day.date.year,
            day.date.month,
            day.date.day,
            indexListTimetoHoure(i),indexListTimetoMinute(i)
        );
        var dateEnd = new DateTime(
            day.date.year,
            day.date.month,
            day.date.day,
            indexListTimetoHoure(i)+1,indexListTimetoMinute(i)
        );
        String dateDebutString = dateStart.toUtc().toIso8601String();
        String dateFinStirng = dateEnd.toUtc().toIso8601String();
        var dispo =Disponibility(
          dateStart: dateDebutString,
          dateEnd: dateFinStirng,
          dispotype: appTypeToString(day.listTimes[i].appointmentType),
          title: "reunion",
          allDay: false,
          description: "reunion des",
        );
        dislist.add(dispo);
      }
    }
    return dislist;
  }
  int indexListTimetoHoure(int i){
    switch(i){
      case 0 : return 9;
      break;
      case 1 : return 10;
      break;
      case 2: return 12;
      break;
      case 3 : return 14;
      break;
      case 4 : return 15;
      break;
      case 5: return 17;
      break;
      case 6 : return 18;
      break;
      case 7 : return 19;
      break;
      case 8 : return 20;
      break;
    }
  }
  int indexListTimetoMinute(int i){
    switch(i){
      case 0 : return 0;
      break;
      case 1 : return 30;
      break;
      case 2: return 0;
      break;
      case 3 : return 0;
      break;
      case 4 : return 30;
      break;
      case 5: return 0;
      break;
      case 6 : return 30;
      break;
      case 7 : return 0;
      break;
      case 8 : return 0;
      break;
    }
  }
  List<Time> allSelectedTime(FullCalendarDay day){
    List<Time> times =[];
    for(var time in day.listTimes){
      if(time.selected){
        times.add(time);
      }
    }
    return times;
  }
  List<CalendarMonth>getMonths(List<CalendarYear> years){
    List<CalendarMonth>months = List<CalendarMonth>();
    for(var year in years){
      for(var month in year.months){
        months.add(month);
      }
    }
    months.removeRange(0, DateTime.now().month-1);
    months[0].days.removeRange(0, DateTime.now().day);
    return months;
  }
  List<FullCalendarDay>getDayMonths(CalendarMonth month){
    List<FullCalendarDay> days = List<FullCalendarDay>();
        for(var day in month.days){
          days.add(
            day
          );
        }

    return days;
  }

  String getMonthName(int _month){
    switch(_month){
      case 1: return "Janvier";
      break;
      case 2: return "Février";
      break;
      case 3: return "Mars";
      break;
      case 4: return "Avril";
      break;
      case 5: return "Mai";
      break;
      case 6: return "Juin";
      break;
      case 7: return "Juillet";
      break;
      case 8: return "Août";
      break;
      case 9: return "Septembre";
      break;
      case 10: return "Octobre";
      break;
      case 11: return "Novembre";
      break;
      case 12: return "Décembre";
      break;
    }
  }
  String engDayToFr(String dayName){
    switch(dayName){
      case "Monday" : return "Lundi";
      break;
      case "Tuesday" : return "Mardi";
      break;
      case "Wednesday" : return "Mercredi";
      break;
      case "Thursday" : return "Jeudi";
      break;
      case "Friday" : return "Vendredi";
      break;
      case "Saturday" : return "Samedi";
      break;
      case "Sunday" : return "Dimanche";
      break;
    }
  }
}
class FullCalendar{
  bool selected = false;
  bool premium = false;
  List<CalendarYear>years;
   List<CalendarMonth>freeMonths;
  FullCalendar.fromJson(Map<String, dynamic> json) {
    premium= json['premium'];
    selected= json['selected'];
    if (json['years'] != null) {
      years = new List<CalendarYear>();
      json['years'].forEach((v) {
        years.add(new CalendarYear.fromJson(v));
      });
    }
    if (json['freeMonths'] != null) {
      freeMonths = new List<CalendarMonth>();
      json['freeMonths'].forEach((v) {
        freeMonths.add(new CalendarMonth.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['premium'] = this.premium;
    data['selected'] = this.selected;
    if (this.years != null) {
      data['years'] = this.years.map((v) => v.toJson()).toList();
    }
    if (this.freeMonths != null) {
      data['freeMonths'] = this.freeMonths.map((v) => v.toJson()).toList();
    }
    return data;
  }
  FullCalendar({this.years, this.freeMonths,this.premium});
}
class CalendarYear{
   List<CalendarMonth>months;
   int year;
  CalendarYear({this.months,this.year});
  CalendarYear.fromJson(Map<String, dynamic> json) {
    year= json['year'];
    if (json['months'] != null) {
      months = new List<CalendarMonth>();
      json['months'].forEach((v) {
        months.add(new CalendarMonth.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    if (this.months != null) {
      data['months'] = this.months.map((v) => v.toJson()).toList();
    }
    return data;
  }

}
class CalendarMonth{
   int year ;
  List<FullCalendarDay>days;
  int month;
  String monthName;
 bool available ;
 bool checked ;
 bool selected = false;
 int index;
  List<Time>listTimes =[Time(title: "09:00 AM",selected: false),Time(title: "10:30 AM",selected: false),
    Time(title: "12:00 PM",selected: false),Time(title: "14:00 PM",selected: false),
    Time(title: "15:30 PM",selected: false),Time(title: "17:00 PM",selected: false),
    Time(title: "18:30 PM",selected: false),Time(title: "19:00 PM",selected: false),
    Time(title: "20:00 PM",selected: false)];
 CalendarMonth({this.days,this.year,this.monthName,this.month,this.available,this.checked,this.selected,this.index});
  CalendarMonth.fromJson(Map<String, dynamic> json) {
    year= json['year'];
    monthName= json['monthName'];
    month= json['month'];
    available= json['available'];
    checked= json['checked'];
    selected= json['selected'];
    index= json['index'];
    if (json['timeMonth'] != null) {
      listTimes = new List<Time>();
      json['timeMonth'].forEach((v) {
        listTimes.add(new Time.fromJson(v));
      });
    }
    if (json['days'] != null) {
      days = new List<FullCalendarDay>();
      json['days'].forEach((v) {
        days.add(new FullCalendarDay.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['monthName'] = this.monthName;
    data['month'] = this.month;
    data['available'] = this.available;
    data['checked'] = this.checked;
    data['selected'] = this.selected;
    data['index'] = this.index;
    if (this.listTimes != null) {
      data['timeMonth'] = this.listTimes.map((v) => v.toJson()).toList();
    }
    if (this.days != null) {
      data['days'] = this.days.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FullCalendarDay{
  int year;
  String monthName;
  int month;
  int day;
  DateTime date;
  String dayName;
  bool selected;
  int index;
  List<Time>listTimes =[Time(title: "09:00 AM",selected: false),Time(title: "10:30 AM",selected: false),
    Time(title: "12:00 PM",selected: false),Time(title: "14:00 PM",selected: false),
    Time(title: "15:30 PM",selected: false),Time(title: "17:00 PM",selected: false),
    Time(title: "18:30 PM",selected: false),Time(title: "19:00 PM",selected: false),
    Time(title: "20:00 PM",selected: false)];
   bool thisMonth;
   bool prevMonth;
   bool nextMonth;
  FullCalendarDay.fromJson(Map<String, dynamic> json) {
     year= json['year'];
     monthName= json['monthName'];
     month= json['month'];
     day= json['day'];
     date= DateTime.parse(json['date']);
     dayName= json['dayName'];
     selected= json['selected'];
     index= json['index'];
     thisMonth= json['thisMonth'];
     prevMonth= json['prevMonth'];
     nextMonth= json['nextMonth'];
     if (json['time'] != null) {
       listTimes = new List<Time>();
       json['time'].forEach((v) {
         listTimes.add(new Time.fromJson(v));
       });
     }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['monthName'] = this.monthName;
    data['month'] = this.month;
    data['day'] = this.day;
    data['date'] = this.date.toIso8601String();
    data['dayName'] = this.dayName;
    data['selected'] = this.selected;
    data['index'] = this.index;
    data['thisMonth'] = this.thisMonth;
    data['prevMonth'] = this.prevMonth;
    data['nextMonth'] = this.nextMonth;
    if (this.listTimes != null) {
      data['time'] = this.listTimes.map((v) => v.toJson()).toList();
    }
    return data;
  }
  FullCalendarDay({
    this.date,
    this.day,
    this.dayName,
    this.monthName,
    this.month,
    this.year,
    this.nextMonth,
    this.prevMonth,
    this.thisMonth,
    this.selected,
    this.index
  });
}

class Time {
  String title;
  bool selected;
  AppointmentType appointmentType;
  Time({this.title,this.selected,this.appointmentType});
  Time.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    selected = json['selected'];
    appointmentType = stringToAppType(json['appointmentType']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['selected'] = this.selected;
    data['appointmentType'] = appTypeToString(this.appointmentType);
    return data;
  }
}

String appTypeToString(AppointmentType appointmentType){
  switch(appointmentType){
    case AppointmentType.PHYSICAL : return "Visite_physique";
    break;
    case AppointmentType.VIRTUAL : return "Visite_virtuelle";
    break;
    case AppointmentType.GROUP : return "Visite_groupe";
    break;
  }
}
AppointmentType stringToAppType(String string){
  switch(string){
    case "Visite_physique" : return AppointmentType.PHYSICAL;
    break;
    case "Visite_virtuelle" : return AppointmentType.VIRTUAL;
    break;
    case "Visite_groupe" : return AppointmentType.GROUP;
    break;
  }
}
enum AppointmentType {PHYSICAL, VIRTUAL, GROUP}

