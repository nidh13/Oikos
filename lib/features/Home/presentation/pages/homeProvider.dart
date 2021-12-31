import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Home/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Home/presentation/bloc/home_bloc.dart';
import 'package:oikosmobile/features/Home/presentation/pages/homePage.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class HomeProvider extends StatelessWidget {
  final User user;
  final String token;
  bool fromAppBar = false;
  final List<PropertiesModel>listProp;

   HomeProvider({Key key,@required this.user,this.token,this.listProp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listProp.isNotEmpty?WillPopScope(
      onWillPop: () => null,
      child: BlocProvider(
            create: (_) => sl<HomeBloc>()..add(GoHomeDisplayEvent()),
            child: HomePage(user: user,token: token,listProp: listProp,fromLogout: fromAppBar,),
          )
    ):BlocProvider(
      create: (_) => sl<HomeBloc>()..add(GoHomeDisplayFirstConnexionEvent()),
      child: HomePage(user: user,token: token,listProp: listProp,fromLogout: fromAppBar,),
    );
  }
}