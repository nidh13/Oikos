import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBackground.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customInput.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/socialMediaWidget.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_bloc.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_event.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginDisplay extends StatefulWidget {
  final String message;

  const LoginDisplay({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  _LoginDIsplayState createState() => _LoginDIsplayState();
}

class _LoginDIsplayState extends State<LoginDisplay> {
 bool _passwordVisible ;
 String email = "";
 String password = "";
 bool popUp = false;
 @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    print("erreur from DisplayLogin");
    print(widget.message);
    if(widget.message!=null&&widget.message!=''){
      popUp = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: CustomBackground(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: BackButton(
                    color: ColorConstant.white,
                    onPressed: () {
                      dispatchGoToWelcomEvent();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          height: 85,
                          width: 140,
                          child: SvgPicture.asset(
                            "Assets/Images/assets_icons_oikos.svg",width: 140,height: 85,
                          ),
                        ),
                        SizedBox(height: 50,),
                        Padding(
                          padding: EdgeInsets.only(bottom:30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImput(
                                labelText: "Email",
                                hintText: "Taper votre email",
                                textInputType: TextInputType.visiblePassword,
                                initialValue: email,
                                onChanged: (value){
                                  email =value;
                                },
                              ),
                              SizedBox(
                                height:11,
                              ),
                              CustomImput(
                                labelText: "Mot de passe",
                                hintText: "Taper votre mot de passe",
                                textInputType: TextInputType.visiblePassword,
                                obscureText: !_passwordVisible,
                                initialValue: password,
                                onChanged: (value){
                                  password=value;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ?Icons.visibility_off_outlined
                                        :Icons.visibility_outlined,
                                    color: ColorConstant.suffixIcon,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: InkWell(
                                  onTap: (){
                                  },
                                  child: CustomText(
                                    value:"Mot de passe oublié?",
                                    color: ColorConstant.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(bottom: 20),
                          child: CustomButton(
                            height:48.0,
                            minWidth: 299,
                            onPressed: (){
                              dispatchLogin(email,password);
                            },
                            text: "CONTINUER",
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.7,
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              dispatchGoToSignupEvent();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  value:"Vous n'avez pas un compte? ",
                                  color: ColorConstant.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  child: CustomText(
                                    value:"Créer un compte",
                                    color: ColorConstant.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    textAlign: TextAlign.center,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 60,),
                        SocialMediaWidget(
                          onPressedGoogle: (){
                            dispatchSigningGoogleEvent();
                          },
                          onPressedFacebook: (){
                            dispatchSigningFacebookEvent();
                          },
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        popUp? Stack(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  popUp = false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 300,
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset("Assets/Images/errorIcon.svg",),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: CustomText(
                              value: ErrorFromMessage(widget.message),
                              color: ColorConstant.darkText,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        text: "Ok",
                        fontWeight:FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 0.7,
                        height: 48,
                        onPressed: (){
                          setState(() {
                            popUp =false;
                          });
                        },
                        minWidth: 135,
                      )

                    ],
                  ),

                ),
              ),
            )
          ],
        ):Container()
      ],
    );
  }
 void dispatchLogin(String email, String password) {
   BlocProvider.of<LoginBloc>(context).add(SigninEvent(
     emailOrPhone: email,
     password: password,
   ));
 }
  void dispatchGoToSignupEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<LoginBloc>(context)
        .add(GoToSignupEvent());
  }
  void dispatchGoToWelcomEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<LoginBloc>(context)
        .add(GotoWelcomEvent());
  }
 void dispatchSigningGoogleEvent() {
   // Clearing the TextField to prepare it for the next inputted number
   BlocProvider.of<LoginBloc>(context)
       .add(SigningGoogleEvent());
 }
 void dispatchSigningFacebookEvent() {
   // Clearing the TextField to prepare it for the next inputted number
   BlocProvider.of<LoginBloc>(context)
       .add(SigningFacebookEvent());
 }
 String ErrorFromMessage(String message){
   switch(message){
     case"no connection on your Device":return "Verfiez connexion dans votre appareil !";
     break;
     case "User is disabled" :return "Votre compte n'est pas encore activé !";
     break ;
     case "Bad credentials" : return "Verfiez votre email et votre password !";
     case "Your account has been enabled. You can login now":return"votre compte a était activé. vous pouver connecter maintenant";
     break;
   }
 }
}
