import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(InitialHomeState());


  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is GoTOAddBienEvent){
      yield GoTOAddBienState() ;
    }
    if(event is GoToServiceEvent){
      yield GoToServiceState() ;
    }
    if(event is GoHomeDisplayEvent){
      yield GoHomeDisplayState() ;
    }
    if(event is GoHomeDisplayFirstConnexionEvent){
      yield GoHomeDisplayFirstConnexionState() ;
    }
    if(event is GoToImagePickEvent){
      yield GoToPickImageState();
    }
    if(event is LogOutEvent){
      yield LogOutState();
    }

  }
  @override
  void onTransition(Transition<HomeEvent, HomeState> transition) {
    print(transition);
  }
}
