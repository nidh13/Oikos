import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Calendar/presentation/pages/calendarPage.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class CalendarProvider extends StatelessWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;

  const CalendarProvider({Key key, this.user, this.token, this.listProp,this.propertiesModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: BlocProvider(
        create: (_) => sl<CalendarBloc>()..add(SelectMonthEvent()),
        child: CalendarPage(propertiesModel: propertiesModel,user: user,token: token,listProp: listProp,),
      )
      ,
    );
  }
}
