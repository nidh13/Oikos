import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';

@immutable
abstract class CalendarEvent extends Equatable {
  CalendarEvent([List props = const <dynamic>[]]) : super();
}
class AddCalendarEvent extends CalendarEvent{

  @override
  List<Object> get props => [];
}
class SelectMonthEvent extends CalendarEvent{
  @override
  List<Object> get props => [];
}
class GoToMonthDisponiblityEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToMonthDisponiblityEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToCustomDisponiblityEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToCustomDisponiblityEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToDisponiblityTimeEvent extends CalendarEvent{
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoToDisponiblityTimeEvent({@required this.date,@required this.time,@required this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoToDayDisponiblityDisplayEvent extends CalendarEvent{
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoToDayDisponiblityDisplayEvent({@required this.date,@required this.time,this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoToUpdateDayDisponiblityDisplayEvent extends CalendarEvent{
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoToUpdateDayDisponiblityDisplayEvent({@required this.date,@required this.time,this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoToAddOntherDayDisponiblityDisplayEvent extends CalendarEvent{
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoToAddOntherDayDisponiblityDisplayEvent({@required this.date,@required this.time,this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoToEveryWeekendEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEveryWeekendEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToEveryWeekendDayDisponibilityDisplayEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEveryWeekendDayDisponibilityDisplayEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToUpdateEveryWeekendDayDisponibilityDisplayEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToUpdateEveryWeekendDayDisponibilityDisplayEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToAddAnotherEveryWeekendDayDisponibilityDisplayEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToAddAnotherEveryWeekendDayDisponibilityDisplayEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToEvery18hWeekendEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEvery18hWeekendEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToEvery18hWeekendDayDisponibilityDisplayEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEvery18hWeekendDayDisponibilityDisplayEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToUpdateEvery18hWeekendDayDisponibilityDisplayEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToUpdateEvery18hWeekendDayDisponibilityDisplayEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToAddAnotherEvery18hWeekendDayDisponibilityDisplayEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToAddAnotherEvery18hWeekendDayDisponibilityDisplayEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToConfirmedCalendarEvent extends CalendarEvent{
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToConfirmedCalendarEvent({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class ConfirmeCalendarEvent extends CalendarEvent{
  final FullCalendar calendar;
  final String token;
  ConfirmeCalendarEvent({@required this.calendar,@required this.token});
  @override
  List<Object> get props => [calendar,token];
}

