import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Profile/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Profile/presentation/pages/profilePage.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class ProfileProvider extends StatelessWidget {
  bool fromAppBar = false;
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;
  ProfileProvider({Key key,this.fromAppBar, this.user, this.token,this.listProp,this.propertiesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: fromAppBar?BlocProvider(
        create: (_) => sl<ProfileBloc>()..add(GoToFirstPageEvent()),
        child: ProfilePage(token: token,user: user,listProp: listProp,),
      ) :BlocProvider(
        create: (_) => sl<ProfileBloc>()..add(GoToImagePickerEvent(firstConexion: true)),
        child: ProfilePage(token: token,user: user,listProp: listProp,),
      )
      ,
    );
  }
}
