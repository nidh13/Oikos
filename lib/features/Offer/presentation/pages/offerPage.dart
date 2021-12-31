import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/loadingAppBarWidget.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Offer/presentation/widgets/offerDisplay.dart';
import 'package:oikosmobile/features/Offer/presentation/widgets/offerListDisplay.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class OfferPage extends StatelessWidget {
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;

  const OfferPage({Key key, this.user, this.token, this.listProp,this.propertiesModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OfferBloc,OfferState>(
        builder: (context,state){
          if(state is GoToOfferListState){
            return OffersListDisplay(token: token,user: user,listProp: listProp,offers: state.offers,propertiesModel: propertiesModel,);
          }
          if(state is LoadingState){
            return LoadingAppBarWidget(token: token,user: user,listProp:listProp,);
          }
          if(state is GoToOfferDisplayState){
            return OfferDisplay(token: token,user: user,listProp: listProp,propertiesModel: propertiesModel,offer: state.offer,sender: state.buyer,);
          }
          if(state is GoToSendMessageState){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(
                  '/MessageProvider',
                  arguments: {
                    'user':user,
                    'token':token,
                    'sendMessage':true,
                    'sender':state.sender,
                    'listProp':listProp,
                  }
              );
            });
          }
          return Container();
        },
      ),
    );
  }
}
