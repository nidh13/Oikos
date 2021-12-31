import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Message/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Message/presentation/pages/messagePage.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class MessageProvider extends StatelessWidget {
  final User user;
  final String token;
  final bool sendMessage;
  final User sender;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;

  const MessageProvider({Key key, this.user, this.token, this.listProp,this.sendMessage,this.sender}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: sendMessage?BlocProvider(
        create: (_) => sl<MessageBloc>()..add(GoToMessageDisplayFromOtherFeatureEvent(token: token,sender: sender)),
        child: MessagePage(token: token,user: user,listProp: listProp,),
      ):BlocProvider(
        create: (_) => sl<MessageBloc>()..add(GoToFirstPageEvent(token: token)),
        child: MessagePage(token: token,user: user,listProp: listProp,),
      ),
    );
  }
}
