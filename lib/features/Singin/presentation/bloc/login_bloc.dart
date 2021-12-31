import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/myProperties.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/confirmSms.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getDepartments.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getProfile.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getUserById.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getUserPicture.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/login.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/loginFacebook.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/loginGoogle.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/registre.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  final Register register;
  final GetProfile getProfile;
  final GetDepartments getDepartments;
  final GetUserPicture getUserPicture;
  final MyProperties myProperties;
  final LoginGoogle loginGoogle;
  final LoginFacebook loginFacebook;
  final GetUserById getUserById;
  final SmsConfirm smsConfirm;


  LoginBloc({@required this.login,
    @required this.register,@required this.getProfile,@required this.getDepartments,@required this.getUserPicture,@required this.myProperties,@required this.loginGoogle,@required this.loginFacebook,@required this.getUserById,@required this.smsConfirm}) : super(SplashScreenDisplayState());


  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is GotoWelcomEvent) {
      yield GoToWelcomState();
    }
    if (event is GoToSignupEvent) {
      yield  LoadingLoginState();
      final failureOrDepartments = await getDepartments(NoParams());
      print(failureOrDepartments);
      yield* failureOrDepartments.fold((failure) async* {
        yield ErrorLoginState(
          message: _mapFailureToMessage(failure),
        );
      }, (list) async* {
        yield GoToSignupState(departments: list);

      });

    }

    if (event is GoToSigninEvent) {
      yield GoToSigninState();
    }

    if (event is GoToForgotPasswordEvent) {
      yield GoToForgotPasswordState();
    }

    if (event is GoToTermsOfUseEvent) {
      yield GoToTermsOfUseState();
    }
    if(event is SigninEvent){
      yield  LoadingLoginState();
      final loginParams = LoginParams(emailOrPhone: event.emailOrPhone,password: event.password);
      final failureOrToken = await login(loginParams);
      yield* failureOrToken.fold((failure) async* {
        print(_mapFailureToMessage(failure));
        yield ErrorLoginState(
          message: _mapFailureToMessage(failure),
        );
      }, (string) async* {
        final failureOrUser = await getProfile(string);
        yield* failureOrUser.fold((failure) async*{
          yield ErrorLoginState(
            message: _mapFailureToMessage(failure),
          );
        }, (user)async*{

          final failureOrListProp = await myProperties(string);
          yield* failureOrListProp.fold(
                  (failure) async* {
                yield ErrorLoginState(
                  message: _mapFailureToMessage(failure),
                );
              },
                  (list) async* {
                    yield LoadedState(token: string,user: user,listProp: list);
              }
          );
        });

      });
    }
    if(event is SignupEvent){
      yield  LoadingLoginState();
      final registerParams = RegisterParams(firstName: event.firstName,lastName: event.lastName,
      password: event.password,departmentNumber: event.departmentNumber,zipCode: event.zipCode,
      street: event.street,birthDate: event.birthDate,phoneNumber: event.phoneNumber,email: event.email);
      final failureOrToken = await register(registerParams);
      yield* failureOrToken.fold((failure) async* {
        yield ErrorRegistreState(
          message: _mapFailureToMessage(failure),departments: event.departments
        );
      }, (string) async* {
          yield GoToSmsConfirmState(phoneNumber: event.phoneNumber);
      });
    }
    if(event is SigningGoogleEvent){
      yield  LoadingLoginState();
      final failureOrLogin = await loginGoogle(NoParams());
      yield* failureOrLogin.fold(
          (failure) async*{
            print(failure);
          },(compte) async*{
            print(compte);
            yield  LoadingLoginState();
            final loginParams = LoginParams(emailOrPhone: "nidhal.mazhoud@gmail.com",password: "Ni96926353@");
            final failureOrToken = await login(loginParams);
            yield* failureOrToken.fold((failure) async* {
              print(_mapFailureToMessage(failure));
              yield ErrorLoginState(
                message: _mapFailureToMessage(failure),
              );
            }, (string) async* {
              final failureOrUser = await getProfile(string);
              yield* failureOrUser.fold((failure) async*{
                yield ErrorLoginState(
                  message: _mapFailureToMessage(failure),
                );
              }, (user)async*{

                final failureOrListProp = await myProperties(string);
                yield* failureOrListProp.fold(
                        (failure) async* {
                      yield ErrorLoginState(
                        message: _mapFailureToMessage(failure),
                      );
                    },
                        (list) async* {
                      yield LoadedState(token: string,user: user,listProp: list);
                    }
                );
              });

            });
      }
      );
    }
    if(event is SigningFacebookEvent){
      final failureOrLogin = await loginFacebook(NoParams());
      yield* failureOrLogin.fold(
              (failure) async*{
            print(failure);
          },(compte) async*{
        print(compte);
      }
      );
    }
    if(event is ConfirmSmsEvent){
      yield  LoadingLoginState();
      final failureOrLogin = await smsConfirm(event.code);
      yield* failureOrLogin.fold(
              (failure) async*{
            print(failure);
          },(string) async*{
        yield ErrorLoginState(message: string);
              }
      );
    }
  }
  @override
  void onEvent(LoginEvent event) {

    super.onEvent(event);
    if(event is SigninEvent){
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    if(failure is ServerFailure){
      return failure.message;
    }else{
      return 'Unexpected Failure';
    }
  }
  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    print(transition);
  }
}

