import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/offer_bloc.dart';
import 'package:oikosmobile/features/Offer/presentation/bloc/offer_bloc.dart';
import 'package:oikosmobile/features/Offer/presentation/pages/offerPage.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

import '../../../../injection_container.dart';

class OfferProvider extends StatelessWidget {
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;

  const OfferProvider({Key key, this.user, this.token, this.listProp, this.propertiesModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: BlocProvider(
        create: (_) => sl<OfferBloc>()..add(GoToOfferListEvent(id: propertiesModel.id,token: token)),
        child: OfferPage(token: token,user: user,listProp: listProp,propertiesModel: propertiesModel,),
      ),
    );
  }
}
