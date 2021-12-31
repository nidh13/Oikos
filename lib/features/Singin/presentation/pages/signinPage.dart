import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/loadingWidget.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_bloc.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_state.dart';
import 'package:oikosmobile/features/Singin/presentation/widgets/TermsPoliceyDisplay.dart';
import 'package:oikosmobile/features/Singin/presentation/widgets/forgotPasswordDisplay.dart';
import 'package:oikosmobile/features/Singin/presentation/widgets/smsConfirmDisplay.dart';
import 'package:oikosmobile/features/Singin/presentation/widgets/welcomDisplay.dart';
import 'package:oikosmobile/features/Singin/presentation/widgets/loginDisplay.dart';
import 'package:oikosmobile/features/Singin/presentation/widgets/registerDisplay.dart';
import 'package:oikosmobile/features/Singin/presentation/widgets/splashScreenDisplay.dart';

class SignInPage  extends StatelessWidget {
  bool fromLogout;

  SignInPage({Key key, this.fromLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context,state){
          if (state is SplashScreenDisplayState) {
            return SplashScreenDisplay();
          }
          if (state is EmptyLoginState) {
            return WelcomeDisplay();
          }

          if (state is LoadingLoginState) {
            return LoadingWidget();
          }
          if(state is LoadedState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(
                '/homeProvider',
                arguments: {
                  'user':state.user,
                  'token':state.token,
                  'listProp':state.listProp
                }
              );
            });
              return WelcomeDisplay();
            }
          if (state is ErrorLoginState) {
            return LoginDisplay(message: state.message,);
          }
          if (state is ErrorRegistreState) {
            return RegisterDisplay(message: state.message,departments: state.departments,);
          }

          if (state is GoToWelcomState) {
            return WelcomeDisplay();
          }
          if (state is GoToSignupState) {
            return RegisterDisplay(departments: state.departments,);
          }

          if (state is GoToSigninState) {
            return LoginDisplay();
          }

          if (state is GoToForgotPasswordState) {
            return ForgotPasswordDisplay();
          }

          if (state is GoToTermsOfUseState) {
            return TermsPoliceyDisplay();
          }
          if (state is RegistredState) {
            return WelcomeDisplay(
             // message: state.message,
            );
          }
          if (state is GoToSmsConfirmState) {
            return SmsConfirmDisplay(phoneNumber: state.phoneNumber,);
          }

          if (state is ForgotPasswordState) {
            return LoginDisplay(
             // message: state.message,
            );
          }
          return LoadingWidget();
        }

    );
  }
}
