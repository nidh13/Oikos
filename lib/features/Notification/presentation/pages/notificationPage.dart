import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/loadingAppBarWidget.dart';
import 'package:oikosmobile/features/Notification/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Notification/presentation/bloc/notification_state.dart';
import 'package:oikosmobile/features/Notification/presentation/widgets/notificationDisplay.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class NotificationPage extends StatelessWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;

  const NotificationPage({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context,state){
            if(state is FirstPageState){
              return NotificationDisplay(user: user,token:token,listProp:listProp,notifications: state.notifications,);
            }
            if(state is LoadingState){
              return LoadingAppBarWidget(token: token,user: user,listProp:listProp,);
            }
            if(state is ReadState){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                    '/BienProvider',
                    arguments: {
                      'user':user,
                      'token':token,
                      'listProp':listProp,
                      'fromAppBar':true,
                    }
                );
              });
            }
            return Container();
          }
      ),
    );
  }
}


