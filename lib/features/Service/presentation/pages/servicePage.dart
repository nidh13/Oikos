import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/loadingAppBarWidget.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/onboardingDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/packDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/pickDateDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/pickLocationDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/pickPackDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/pickPropInformationDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/pickTimeDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/propInformationDisplay.dart';
import 'package:oikosmobile/features/Service/presentation/widgets/servicesDisplay.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class ServicePage extends StatelessWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;

  const ServicePage({Key key, this.user, this.token,this.listProp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context,state){
            if(state is InitialServiceState){
              return ServicesDisplay(user: user,token: token,listProp: listProp,orders: state.orders,);
            }
            if(state is GoToOnBoardingState){
              return OnBoardingDisplay(packs: state.packs,);
            }
            if(state is GoToPickDateState){
              return PickDateServiceDisplay(pack: state.pack,packs: state.packs,);
            }
            if(state is GoToPickPackState){
              return PickPackDisplay(packs: state.packs);
            }
            if(state is GoToPackDisplayState){
              return PackDisplay(pack: state.pack,packs: state.packs,);
            }
            if(state is GoToPickLocationState){
              return PickLocationDisplay(packs: state.packs,token: token,);
            }
            if(state is GoToPickTimeState){
              return PickTimeDisplay(date: state.date,pack: state.pack,packs: state.packs,);
            }
            if(state is GoToPickPropInformationState){
              return PickPropInformation(date: state.date,time: state.time,pack: state.pack,packs: state.packs,token: token,);
            }
            if(state is GoToPropInformationDisplayState){
              return PropInformationDisplay();
            }
            if(state is LoadingServiceState){
              return LoadingAppBarWidget(token: token,user: user,listProp:listProp,);;
            }
            return Container();
          }
      ),
    );
  }
}







