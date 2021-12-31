import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const <dynamic>[]]) : super();
}


class SplashScreenDisplayState extends LoginState {
  @override
  List<Object> get props => [];
}

class SplashScreenWidgetState extends LoginState {
  @override
  List<Object> get props => [];
}

class EmptyLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadedState extends LoginState {
  final String token;
  final User user;
  final List<PropertiesModel>listProp;

  LoadedState({@required this.token,@required this.user,@required this.listProp});

  @override
  List<Object> get props => [token,user,listProp];
}
class GoToSmsConfirmState extends LoginState {
  final String phoneNumber;
  GoToSmsConfirmState({@required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}
class ErrorLoginState extends LoginState {
  final String email;
  final String password;
  final String message;

  ErrorLoginState({
    this.email,
    this.password,
    @required this.message,
  });

  @override
  List<Object> get props => [email,password,message];
}
class ErrorRegistreState extends LoginState {
  final String message;
  List<String> departments;
  ErrorRegistreState({
    @required this.message,@required this.departments,
  });

  @override
  List<Object> get props => [message,departments];
}

class GoToSignupState extends LoginState {
  List<String> departments;

  GoToSignupState({ @required this.departments});

  @override
  List<Object> get props => [departments];

}
class GoToWelcomState extends LoginState {
  @override
  List<Object> get props =>  [];
}
class GoogleSignInState extends LoginState {
  @override
  List<Object> get props =>  [];
}
class FacebookSignInState extends LoginState {
  @override
  List<Object> get props =>  [];
}
class GoToSigninState extends LoginState {
  @override
  List<Object> get props => [];
}

class GoToForgotPasswordState extends LoginState {
  @override
  List<Object> get props => [];
}

class GoToTermsOfUseState extends LoginState {
  @override

  List<Object> get props => ['state'];
}

class RegistredState extends LoginState {
  final String message;

  RegistredState({@required this.message});

  @override
  List<Object> get props => [message];
}

class ForgotPasswordState extends LoginState {
  final String message;

  ForgotPasswordState({@required this.message});

  @override
  List<Object> get props => [message];
}

