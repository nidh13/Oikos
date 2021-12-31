import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super();
}
class GoTOAddBienEvent extends HomeEvent {
  @override

  List<Object> get props => [];
}
class GoToServiceEvent extends HomeEvent {
  @override

  List<Object> get props => [];
}
class GoHomeDisplayEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
class GoHomeDisplayFirstConnexionEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
class GoToImagePickEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
class LogOutEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

