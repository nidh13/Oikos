import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([List props = const <dynamic>[]]) : super();
}

class InitialProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}
class FirstPageState extends ProfileState {
  @override
  List<Object> get props => [];
}
class GoToUpdateProfileState extends ProfileState {
  final List<String> departments;

  GoToUpdateProfileState({@required this.departments});
  @override
  List<Object> get props => [departments];
}
class ImageDisplayState extends ProfileState {
  final bool firstConexion;
  final File image ;
  ImageDisplayState({@required this.image,@required this.firstConexion});

  @override
  List<Object> get props => [image,firstConexion];
}
class ProfileUpdatedState extends ProfileState {
  final User user;
  ProfileUpdatedState({@required this.user});

  @override
  List<Object> get props => [user];
}
class PickImageState extends ProfileState {
  final bool firstConexion;

  PickImageState({@required this.firstConexion});
  @override
  List<Object> get props => [firstConexion];
}
class CroppedState extends ProfileState {
  final bool firstConexion;

  CroppedState({@required this.firstConexion});
  @override
  List<Object> get props => [firstConexion];
}
class LogoutState extends ProfileState {
  @override
  List<Object> get props => [];
}
class LoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}
