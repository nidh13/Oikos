import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oikosmobile/features/Calendar/domain/entities/disponibility_model.dart';
import 'package:oikosmobile/features/Profile/domain/entities/userPicture_model.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/data/models/generalInformation_model.dart';

class LoginParams extends Equatable {
  final String emailOrPhone;
  final String password;


  LoginParams(
      {@required this.emailOrPhone, @required this.password})
      : super();

  @override
  List<Object> get props => [emailOrPhone, password];
}

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String phoneNumber;
  final String birthDate;
  final String street;
  final String zipCode;
  final int departmentNumber;

  RegisterParams({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.phoneNumber,
    @required this.birthDate,
    @required this.street,
    @required this.zipCode,
    @required this.departmentNumber,
  }) : super();

  @override
  List<Object> get props => [firstName, lastName, email, password,phoneNumber,birthDate,street,zipCode,departmentNumber];
}
class UpdateProfileParams extends Equatable {
  final String token;
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String phoneNumber;

  UpdateProfileParams({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.phoneNumber,
    @required this.token,
  }) : super();

  @override
  List<Object> get props => [token,firstName, lastName, email, password,phoneNumber];
}

class UpdateGeneralInformationParams extends Equatable {
  final String token;
  final GeneralInformationModel generalInformationModel;

  UpdateGeneralInformationParams({
    @required this.token,
    @required this.generalInformationModel,
  }) : super();

  @override
  List<Object> get props => [token,generalInformationModel];
}
class CreatePropertiesParams extends Equatable{
  final PropertiesModel properties;
  final String token ;

  CreatePropertiesParams({@required this.properties,@required this.token}):super();

  @override
  List<Object> get props => [properties,token];

}
class UpdateImageParams extends Equatable{
  final File image;
  final String token ;

  UpdateImageParams({@required this.image,@required  this.token}):super();

  @override
  List<Object> get props => [image,token];


}
class UploadPropImageParams extends Equatable{
  final File image;
  final String token ;
  final String id;

  UploadPropImageParams({@required this.image,@required  this.token,this.id}):super();

  @override
  List<Object> get props => [image,token,id];


}
class GetPropertiesFilesParams extends Equatable{
  final String token ;
  final String id;

  GetPropertiesFilesParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];


}
class ResetPasswordParams extends Equatable{
  final String token ;
  final String password;

  ResetPasswordParams({@required  this.token,this.password}):super();

  @override
  List<Object> get props => [token,password];


}
class EstimateParams extends Equatable{
  final String token ;
  final String id;

  EstimateParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
class GetPropertiesByIdParams extends Equatable{
  final String token ;
  final String id;

  GetPropertiesByIdParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
class GetNotificationByIdParams extends Equatable{
  final String token ;
  final String id;

  GetNotificationByIdParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
class DeleteImagesParams extends Equatable{
  final String token ;
  final List<String> imageId;

  DeleteImagesParams({@required  this.token,this.imageId}):super();

  @override
  List<Object> get props => [token,imageId];

}
class DeleteImPropertiesParams extends Equatable{
  final String token ;
  final String id;

  DeleteImPropertiesParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
class GetAllPropertiesWithStatusParams extends Equatable{
  final String token ;
  final String status;

  GetAllPropertiesWithStatusParams({@required  this.token,this.status}):super();

  @override
  List<Object> get props => [token,status];

}
class GetMyPropertiesWithStatusParams extends Equatable{
  final String token ;
  final String status;

  GetMyPropertiesWithStatusParams({@required  this.token,this.status}):super();

  @override
  List<Object> get props => [token,status];

}
class GetAllByPropertiesParams extends Equatable{
  final String token ;
  final String id;

  GetAllByPropertiesParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
class GetMessageThreadParams extends Equatable{
  final String token ;
  final String id;

  GetMessageThreadParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
class SendMessageParams extends Equatable{
  final String token ;
  final String senderId;
  final String content;

  SendMessageParams({@required  this.token,@required this.senderId,@required this.content}):super();

  @override
  List<Object> get props => [token,senderId,content];

}
class GetUserByIdParams extends Equatable{
  final String token ;
  final String id;

  GetUserByIdParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
class CounterOfferParams extends Equatable{
  final String token ;
  final String id;
  final double amount;
  final String endsAt;
  CounterOfferParams({@required  this.token,this.id,this.amount,this.endsAt}):super();

  @override
  List<Object> get props => [token,id,endsAt,amount];

}
class AddManyDisponibilityParams extends Equatable{
  final List<Disponibility> disponibilitys;
  final String token ;

  AddManyDisponibilityParams({@required this.disponibilitys,@required this.token}):super();

  @override
  List<Object> get props => [disponibilitys,token];

}
class PayParams extends Equatable{
  final String token ;
  final String id;

  PayParams({@required  this.token,this.id}):super();

  @override
  List<Object> get props => [token,id];

}
