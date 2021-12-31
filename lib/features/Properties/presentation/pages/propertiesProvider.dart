import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Properties/presentation/pages/propertiesPage.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class PropertiesProvider extends StatelessWidget {
  bool fromAppBar = false;
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;

  PropertiesProvider({Key key, this.fromAppBar,this.user,this.token,this.listProp}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
     child:fromAppBar? BlocProvider(
        create: (_) => sl<PropertiesBloc>()..add(GoToFirstPageEvent(token: token)),
        child: PropertiesPage(token: token,user: user,listProp: listProp,),//fromHome: fromHome,
      ):BlocProvider(
       create: (_) => sl<PropertiesBloc>()..add(GoTOAddPropertiesEvent(token: token)),
       child: PropertiesPage(token: token,user: user,listProp: listProp,),//fromHome: fromHome,
     )
      ,
    );
  }
}
