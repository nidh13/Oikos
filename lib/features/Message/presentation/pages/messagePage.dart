import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/loadingAppBarWidget.dart';
import 'package:oikosmobile/features/Message/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Message/presentation/widgets/chatDisplay.dart';
import 'package:oikosmobile/features/Message/presentation/widgets/messageDisplay.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class MessagePage extends StatelessWidget {
  final User user;
  final String token;
  // bool fromAppBar = false;
  final List<PropertiesModel>listProp;

  const MessagePage({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MessageBloc, MessageState>(
          builder: (context,state){
            if(state is FirstPageState){
              return ChatDisplay(user: user,token: token,listProp: listProp,messageThreads: state.messageThreads,);
            }
            if(state is MessageDisplayState){
              return MessageDisplay(user: user,token: token,listProp: listProp,sender: state.sender,messageThread: state.messageThread,);
            }
            if(state is MessageDisplayState){
              return MessageDisplay(user: user,token: token,listProp: listProp,sender: state.sender,messageThread: state.messageThread,);
            }
            if(state is GoToMessageDisplayFromOtherFeatureState){
              return MessageDisplay(user: user,token: token,listProp: listProp,sender: state.sender,messageThread: state.messageThread,);
            }
            if(state is LoadingState ){
              return LoadingAppBarWidget(token: token,user: user,listProp:listProp,);
            }
            return Container();
          }
      ),
    );
  }
}


