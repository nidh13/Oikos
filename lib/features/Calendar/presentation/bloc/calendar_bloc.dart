import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/Utils/sharedPref.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Calendar/domain/use_cases/addMany.dart';
import './bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final AddMany addMany;
  CalendarBloc({@required this.addMany}) : super(LoadingState());

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if(event is SelectMonthEvent){
      SharedPref sharedPref =SharedPref();
      bool contain = await sharedPref.contain("calendar");
      if(contain){
        FullCalendar c = FullCalendar.fromJson(await sharedPref.read("calendar"));
        if(c.selected){
          var free = c.freeMonths[1];
          var m =CustomCalendar().getMonthFromYears(c.years,free.year, free.month);
          yield  GoToConfirmedCalendarState(calendarMonth: m,calendar: c);
        }
        else{
          yield SelectMonthState(calendar: c);
        }
      }else{
        yield SelectMonthState();
      }


    }
    if(event is GoToMonthDisponiblityEvent){
      yield  GoToMonthDisponiblityState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToCustomDisponiblityEvent){
      yield GoToCustomDisponiblityState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToDisponiblityTimeEvent){
      yield GoToDisponiblityTimeState(date: event.date,time: event.time,calendar: event.calendar);
    }
    if(event is GoToDayDisponiblityDisplayEvent){
      yield GoTODayDisponiblityDisplayState(date: event.date,time: event.time,calendar: event.calendar);
    }
    if(event is GoToUpdateDayDisponiblityDisplayEvent){
      yield GoTOUpdateDayDisponiblityDisplayState(date: event.date,time: event.time,calendar: event.calendar);
    }
    if(event is GoToAddOntherDayDisponiblityDisplayEvent){
      yield GoTOAddOntherDayDisponiblityDisplayState(date: event.date,time: event.time,calendar: event.calendar);
    }
    if(event is GoToEveryWeekendEvent){
      yield GoToEveryWeekendState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToEveryWeekendDayDisponibilityDisplayEvent){
      yield GoToEveryWeekendDisponibilityDisplayState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToUpdateEveryWeekendDayDisponibilityDisplayEvent){
      yield GoToUpdateEveryWeekendDisponibilityDisplayState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToAddAnotherEveryWeekendDayDisponibilityDisplayEvent){
      yield GoToAddAnotherEveryWeekendDayDisponibilityDisplayState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToEvery18hWeekendEvent){
      yield GoToEvery18hWeekendState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToEvery18hWeekendDayDisponibilityDisplayEvent){
      yield GoToEvery18hWeekendDisponibilityDisplayState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToUpdateEvery18hWeekendDayDisponibilityDisplayEvent){
      yield GoToUpdateEvery18hWeekendDisponibilityDisplayState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToAddAnotherEvery18hWeekendDayDisponibilityDisplayEvent){
      yield GoToAddAnotherEvery18hWeekendDayDisponibilityDisplayState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is GoToConfirmedCalendarEvent){
      yield GoToConfirmedCalendarState(calendarMonth: event.calendarMonth,calendar: event.calendar);
    }
    if(event is ConfirmeCalendarEvent){
      var list =  CustomCalendar().getAllDisponibility(event.calendar);
      final addManyDisponibilityParams = AddManyDisponibilityParams(
          token: event.token, disponibilitys: list);
      final failureOrProperties = await addMany(addManyDisponibilityParams);
      yield* failureOrProperties.fold(
          (failure) async*{
            print(_mapFailureToMessage(failure));
          },(list) async*{
            print( "ok");
        SharedPref sharedPref =SharedPref();
        await sharedPref.save("calendar", event.calendar);
        yield GoToPropertiesPageState();
      }
      );
    }
  }
  @override
  void onTransition(Transition<CalendarEvent, CalendarState> transition) {
    print(transition);
    super.onTransition(transition);
  }
  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    if (failure is ServerFailure) {
      return failure.message;
    } else {
      return 'Unexpected Failure';
    }
  }
}
