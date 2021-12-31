import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/features/Singin/presentation/pages/signinPage.dart';
import '../bloc/bloc.dart';
import '../../../../injection_container.dart';

class SigninProvider extends StatelessWidget {
  final bool fromLogout;
  const SigninProvider({Key key, this.fromLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(fromLogout!=null){
      return WillPopScope(
        onWillPop: () => null,
        child: fromLogout?BlocProvider(
          create: (_) => sl<LoginBloc>()..add(GotoWelcomEvent()),
          child: SignInPage(fromLogout: fromLogout,),
        ):BlocProvider(
          create: (_) => sl<LoginBloc>(),
          child: SignInPage(),
        ),
      );
    }else{
      return WillPopScope(child: BlocProvider(
        create: (_) => sl<LoginBloc>(),
        child: SignInPage(),
      ), onWillPop: () => null,);
    }

  }
}
