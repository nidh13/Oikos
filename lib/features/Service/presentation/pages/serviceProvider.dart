import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_bloc.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_event.dart';
import 'package:oikosmobile/features/Service/presentation/pages/servicePage.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class ServiceProvider extends StatelessWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;

  const ServiceProvider({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: BlocProvider(
        create: (_) => sl<ServiceBloc>()..add(InitialServiceEvent(token: token)),
        child: ServicePage(token: token,user: user,listProp: listProp,),
      )
      ,
    );
  }
}
