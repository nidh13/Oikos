import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/loadingAppBarWidget.dart';
import 'package:oikosmobile/core/Utils/loadingWidget.dart';
import 'package:oikosmobile/features/Profile/presentation/bloc/profile_bloc.dart';
import 'package:oikosmobile/features/Profile/presentation/bloc/profile_state.dart';
import 'package:oikosmobile/features/Profile/presentation/widgets/imageDisplay.dart';
import 'package:oikosmobile/features/Profile/presentation/widgets/imagePick.dart';
import 'package:oikosmobile/features/Profile/presentation/widgets/profileDisplay.dart';
import 'package:oikosmobile/features/Profile/presentation/widgets/updateProfile.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;

  const ProfilePage({Key key, this.user, this.token,this.listProp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context,state){
            if(state is FirstPageState){
              return ProfileDisplay(user: user,token: token,listProp: listProp,);
            }
            if(state is ImageDisplayState){
              return ImageDisplay(
                image: state.image,
                token: token,
                firstConexion: state.firstConexion,
              );
            }
            if(state is PickImageState){
              return ImagePick(firstConexion: state.firstConexion,);
            }
            if(state is GoToUpdateProfileState){
              return UpdateProfile(departments: state.departments,user: user,token: token,);
            }
            if(state is CroppedState){
              if(state.firstConexion){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacementNamed(
                      '/homeProvider',
                      arguments: {
                        'user':user,
                        'token':token,
                        'listProp':listProp
                      }
                  );
                });
              }else{
                return ProfileDisplay(user: user,token: token,listProp: listProp,);
              }
            }
            if(state is ProfileUpdatedState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                    '/ProfileProvider',
                    arguments: {
                      'user':state.user,
                      'token':token,
                      'listProp':listProp,
                      'fromAppBar':true,
                    }
                );
              });
            }
            if(state is LogoutState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                    '/signinProvider',
                    arguments: true
                );
              });
            }
            if(state is LoadingState){
              return LoadingWidget();
            }
            return Container();
          }
      ),
    );
  }
}

