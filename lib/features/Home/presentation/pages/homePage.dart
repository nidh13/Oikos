import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/loadingWidget.dart';
import 'package:oikosmobile/features/Home/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Home/presentation/widgets/homeDisplay.dart';
import 'package:oikosmobile/features/Home/presentation/widgets/homeDisplayFirstConnexion.dart';
import 'package:oikosmobile/features/Home/presentation/widgets/test.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class HomePage  extends StatelessWidget {
  bool fromLogout;
  final User user;
  final String token;
  final List<PropertiesModel>listProp;


  HomePage({Key key, this.fromLogout,@required this.user,this.token,this.listProp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context,state){
            if(state is GoTOAddBienState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                  '/BienProvider',
                    arguments: {
                      'user':user,
                      'token':token,
                      'fromAppBar':false,
                      'listProp':listProp
                    }
                );
              });
             return LoadingWidget();
            }
            if(state is GoToServiceState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                    '/ServiceProvider',
                    arguments: {
                      'user':user,
                      'token':token,
                      'listProp':listProp
                    }
                );
              });
              return LoadingWidget();
            }
            if(state is GoHomeDisplayFirstConnexionState){
              return HomeDisplayFirstConnexion(user:user,token: token);
            }
            if(state is GoHomeDisplayState){
              return HomePageTest(user: user,token: token,listProp: listProp,);
            }
            if(state is GoToPickImageState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                    '/ProfileProvider',
                    arguments: {
                      'user':user,
                      'token':token,
                      'fromAppBar':false,
                      'listProp':listProp
                    }
                );
              });
            }
            if(state is LogOutState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                    '/signinProvider',
                    arguments: true
                );
              });
            }
            return Container();
          }
      ),
    );
  }
}
