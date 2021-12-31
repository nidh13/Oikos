
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Singin/data/models/generalInformation_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const <dynamic>[]]) : super();
}

class GoToFirstPageEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}
class GoToImageDisplayEvent extends ProfileEvent {
  final bool firstConexion;
 final File image;
  GoToImageDisplayEvent({@required this.image,@required this.firstConexion}):super([image,firstConexion]);

  @override
  List<Object> get props => [image,firstConexion];
}
class GoToUpdateProfileEvent extends ProfileEvent {
  GoToUpdateProfileEvent():super([]);

  @override
  List<Object> get props => [];
}
class GoToImagePickerEvent extends ProfileEvent{
  final bool firstConexion;

  GoToImagePickerEvent({@required this.firstConexion});
  @override

  List<Object> get props => [firstConexion];
}

class CropEvent extends ProfileEvent {
  final File image;
  final String token;
  final bool firstConexion;

  CropEvent({@required this.image,@required this.token,@required this.firstConexion}):super([image,token,firstConexion]);

  @override
  List<Object> get props => [image,token];

}
class UpdateProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String phoneNumber;
  final String token;


  UpdateProfileEvent({@required this.token,@required this.firstName,
    @required this.lastName,@required this.password,
    @required this.email,@required this.phoneNumber,}):super([token,firstName,lastName,password,email,phoneNumber]);

  @override
  List<Object> get props => [token,firstName,lastName,password,email,phoneNumber];

}
class UpdateGeneralInformationEvent extends ProfileEvent {
  final String token;
  final GeneralInformationModel generalInformationModel;


  UpdateGeneralInformationEvent({@required this.token,@required this.generalInformationModel,})
      :super([token,generalInformationModel]);

  @override
  List<Object> get props => [token,generalInformationModel];

}

