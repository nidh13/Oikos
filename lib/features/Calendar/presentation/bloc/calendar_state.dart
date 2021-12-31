import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';

@immutable
abstract class CalendarState extends Equatable {
  CalendarState([List props = const <dynamic>[]]) : super();
}

class AddCalendarState extends CalendarState {
  @override
  List<Object> get props => [];
}
class SelectMonthState extends CalendarState {
  final FullCalendar calendar;
  SelectMonthState({@required this.calendar});
  @override
  List<Object> get props => [calendar];
}
class GoToMonthDisponiblityState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToMonthDisponiblityState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToCustomDisponiblityState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToCustomDisponiblityState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToDisponiblityTimeState extends CalendarState {
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoToDisponiblityTimeState({@required this.date,@required this.time,@required this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoTODayDisponiblityDisplayState extends CalendarState {
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoTODayDisponiblityDisplayState({@required this.date,@required this.time,@required this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoTOUpdateDayDisponiblityDisplayState extends CalendarState {
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoTOUpdateDayDisponiblityDisplayState({@required this.date,@required this.time,@required this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoTOAddOntherDayDisponiblityDisplayState extends CalendarState {
  final FullCalendarDay date;
  final int time;
  final FullCalendar calendar;
  GoTOAddOntherDayDisponiblityDisplayState({@required this.date,@required this.time,@required this.calendar});
  @override
  List<Object> get props => [date,time,calendar];
}
class GoToEveryWeekendState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEveryWeekendState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToEveryWeekendDisponibilityDisplayState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEveryWeekendDisponibilityDisplayState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToUpdateEveryWeekendDisponibilityDisplayState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToUpdateEveryWeekendDisponibilityDisplayState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToAddAnotherEveryWeekendDayDisponibilityDisplayState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToAddAnotherEveryWeekendDayDisponibilityDisplayState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToEvery18hWeekendState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEvery18hWeekendState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToEvery18hWeekendDisponibilityDisplayState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToEvery18hWeekendDisponibilityDisplayState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToUpdateEvery18hWeekendDisponibilityDisplayState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToUpdateEvery18hWeekendDisponibilityDisplayState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToAddAnotherEvery18hWeekendDayDisponibilityDisplayState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToAddAnotherEvery18hWeekendDayDisponibilityDisplayState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class GoToConfirmedCalendarState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  GoToConfirmedCalendarState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class ConfirmeCalendarLoadedState extends CalendarState {
  final CalendarMonth calendarMonth;
  final FullCalendar calendar;
  ConfirmeCalendarLoadedState({@required this.calendarMonth,@required this.calendar});
  @override
  List<Object> get props => [calendarMonth,calendar];
}
class LoadingState extends CalendarState {
  @override
  List<Object> get props => [];
}
class GoToPropertiesPageState extends CalendarState {
  @override
  List<Object> get props => [];
}