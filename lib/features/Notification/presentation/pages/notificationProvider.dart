import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Notification/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Notification/presentation/pages/notificationPage.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class NotificationProvider extends StatelessWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;

  const NotificationProvider({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: BlocProvider(
        create: (_) => sl<NotificationBloc>()..add(GoToFirstPageEvent(token: token)),
        child: NotificationPage(token: token,user: user,listProp: listProp,),
      )
      ,
    );
  }
}
