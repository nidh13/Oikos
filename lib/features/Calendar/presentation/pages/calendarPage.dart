import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/calendar_state.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/addAnother18hWeekendDisponiblityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/addCalendarDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/addOntherDayDisponibilityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/addOntherEveryWeekendDisponibilityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/confirmedCalendarDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/customDisponibility.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/dayDisponiblityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/diponiblityTime.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/every18hWeekend.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/every18hWeekendDisponiblityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/everyWeekend.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/everyWeekendDisponibilityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/monthDisponiblity.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/selectMonth.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/updateDayDiponibilityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/updateEvery18hweekendDisponibilityDisplay.dart';
import 'package:oikosmobile/features/Calendar/presentation/widgets/updateEveryWeeknedDiponibilityDisplay.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class CalendarPage extends StatelessWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;

  const CalendarPage({Key key, this.user, this.token, this.listProp,this.propertiesModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CalendarBloc,CalendarState>(
        builder: (context,state){
          if(state is SelectMonthState){
            return SelectMonth(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendar: state.calendar,);
          }
          if(state is GoToMonthDisponiblityState){
            return MonthDisponiblity(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToCustomDisponiblityState){
            return CustomDiponibility(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToDisponiblityTimeState){
            return DisponibltyTime(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,date:state.date ,time: state.time,calendar: state.calendar);
          }
          if(state is GoTODayDisponiblityDisplayState){
            return DayDisponiblityDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,date:state.date ,time: state.time,calendar: state.calendar);
          }
          if(state is GoTOUpdateDayDisponiblityDisplayState){
            return UpdateDayDisponiblityDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,date:state.date ,time: state.time,calendar: state.calendar);
          }
          if(state is GoTOAddOntherDayDisponiblityDisplayState){
            return AddOntherDayDisponibility(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,date:state.date ,time: state.time,calendar: state.calendar);
          }
          if(state is GoToEveryWeekendState){
            return EveryWeekend(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToEveryWeekendDisponibilityDisplayState){
            return EveryWeekendDisponibilityDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToUpdateEveryWeekendDisponibilityDisplayState){
            return UpdateEveryWeekendDisponibilityDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToAddAnotherEveryWeekendDayDisponibilityDisplayState){
            return AddAnotherEveryWeekendDisponibilityDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToEvery18hWeekendState){
            return Every18hWeekend(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToEvery18hWeekendDisponibilityDisplayState){
            return Every18hWeekendDisponibilityDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToUpdateEvery18hWeekendDisponibilityDisplayState){
            return UpdateEvery18hweekendDisponibility(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToAddAnotherEvery18hWeekendDayDisponibilityDisplayState){
            return AddAnotherEvery18hDisponibilityDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToConfirmedCalendarState){
            return ConfirmedCalendarDisplay(token: token,listProp: listProp,user: user,propertiesModel: propertiesModel,calendarMonth: state.calendarMonth,calendar: state.calendar,);
          }
          if(state is GoToPropertiesPageState){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(
                  '/BienProvider',
                  arguments: {
                    'user':user,
                    'token':token,
                    'fromAppBar':true,
                    'listProp':listProp
                  }
              );
            });
          }

          return Container();
        },
      ),
    );
  }
}
