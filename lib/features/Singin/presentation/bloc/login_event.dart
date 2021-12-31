import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super();
}

class SigninEvent extends LoginEvent {
  final String emailOrPhone;
  final String password;

  SigninEvent(
      {@required this.emailOrPhone,
        @required this.password,
       })
      : super([emailOrPhone, password]);

  @override
  List<Object> get props => [emailOrPhone,password];

}
class ConfirmSmsEvent extends LoginEvent {
  final String code;

  ConfirmSmsEvent(
      {@required this.code,
      })
      : super([code]);

  @override
  List<Object> get props => [code];

}
class SignupEvent extends LoginEvent {
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String phoneNumber;
  final String birthDate;
  final String street;
  final String zipCode;
  final int departmentNumber;
  List<String> departments;
  SignupEvent({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.phoneNumber,
    @required this.birthDate,
    @required this.street,
    @required this.zipCode,
    @required this.departmentNumber,
    @required this.departments,
  }) : super([firstName, lastName, email, password, phoneNumber, birthDate, street, zipCode, departmentNumber,departments]);

  @override
  List<Object> get props => [firstName,lastName,password,email,phoneNumber,birthDate,street,zipCode,departmentNumber];
}
class ForgotPasswordEvent extends LoginEvent {
  final String email;

  ForgotPasswordEvent({
    @required this.email,
  }) : super([email]);

  @override
  List<Object> get props => [email];
}

class SigningGoogleEvent extends LoginEvent {
  @override

  List<Object> get props => [];
}
class SignupGoogleEvent extends LoginEvent {
  @override
  List<Object> get props => ['throw UnimplementedError()'];
}
class SigningFacebookEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class GotoWelcomEvent extends LoginEvent {
  @override
  List<Object> get props =>  [];
}
class GoToSigninEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
class GoToSignupEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
class GoToForgotPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
class GoToTermsOfUseEvent extends LoginEvent {
  @override
  List<Object> get props =>  [];
}
