import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super();
}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}
class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}


class GoHomeDisplayState extends HomeState {
  @override
  List<Object> get props => [];
}
class GoHomeDisplayFirstConnexionState extends HomeState {
  @override
  List<Object> get props => [];
}
class GoTOAddBienState extends HomeState {
  @override
  List<Object> get props => [];

}
class GoToServiceState extends HomeState {
  @override
  List<Object> get props => [];

}
class GoToPickImageState extends HomeState {
  @override
  List<Object> get props => [];
}
class LogOutState extends HomeState {
  @override
  List<Object> get props => [];
}
