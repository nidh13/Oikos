import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Service/domain/usecases/getServices.dart';
import 'package:oikosmobile/features/Service/domain/usecases/payService.dart';
import './bloc.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetServices getServices;
  final PayService payService;
  ServiceBloc({@required this.getServices,@required this.payService}) : super(LoadingServiceState());
  @override
  Stream<ServiceState> mapEventToState(
    ServiceEvent event,
  ) async* {
    if (event is InitialServiceEvent) {
      final failureOrDepartments = await getServices(event.token);
      yield* failureOrDepartments.fold((failure) async* {
        print(failure);
      }, (list) async* {
        yield InitialServiceState(orders: list);
        print("cv");

      });
     // yield InitialServiceState();
    }
    if (event is GoToOnBoardingEvent) {
      yield GoToOnBoardingState(packs: event.packs);
    }
    if (event is GoToPickDateEvent) {
      yield GoToPickDateState(packs: event.packs,pack: event.pack);
    }
    if (event is GoToPickPackEvent) {
      yield GoToPickPackState(packs: event.packs);
    }
    if (event is GoToPackDisplayEvent) {
      yield GoToPackDisplayState(pack: event.pack,packs: event.packs);
    }
    if (event is GoToPickLocationEvent) {
      yield GoToPickLocationState(packs: event.packs);
    }
    if (event is GoToPickTimeEvent) {
      yield GoToPickTimeState(date: event.date,packs: event.packs,pack: event.pack);
    }
    if (event is GoToPickPropInformationEvent) {
      yield GoToPickPropInformationState(date: event.date,time: event.time,packs: event.packs,pack: event.pack);
    }
    if (event is GoToPropInformationDisplayEvent) {
      yield GoToPropInformationDisplayState();
    }
    if(event is PayPhotoServiceEvent){
      yield LoadingServiceState();
      final failureOrUser= await payService(event.payParams);
      yield* failureOrUser.fold(
              (failure)async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
              (string)async*{
                final failureOrDepartments = await getServices(event.payParams.token);
                yield* failureOrDepartments.fold((failure) async* {
                  print(failure);
                }, (list) async* {
                  yield InitialServiceState(orders: list);
                  print("cv");
                });
          }
      );
    }
  }
  @override
  void onTransition(Transition<ServiceEvent, ServiceState> transition) {
    print(transition);
    super.onTransition(transition);
  }
  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    if(failure is ServerFailure){
      return failure.message;
    }else{
      return 'Unexpected Failure';
    }
  }
}




