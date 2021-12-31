import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBackground.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customInput.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_bloc.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_event.dart';

class SmsConfirmDisplay extends StatefulWidget {
 final String phoneNumber;

  const SmsConfirmDisplay({Key key, this.phoneNumber}) : super(key: key);
  @override
  _SmsConfirmDisplayState createState() => _SmsConfirmDisplayState();
}

class _SmsConfirmDisplayState extends State<SmsConfirmDisplay> {
  String code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: BackButton(
                color: ColorConstant.white,
                onPressed: () {
                 // dispatchGoToWelcomEvent();
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        value: "Nous avons envoyé un code pour vérifier votre adresse e-mail",
                        color: ColorConstant.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                        fontSize: 18,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CustomText(
                        value: "Envoyé à "+widget.phoneNumber,
                        color: ColorConstant.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomImput(
                      labelText: "code de confiramtion",
                      hintText: "Taper le code de confirmation",
                      textInputType: TextInputType.visiblePassword,
                      onChanged: (value){
                        code =value;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: RobotoText(
                        value: "Je n'ai pas reçu de code",
                        color: ColorConstant.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        print("renvoyer");
                      },
                      child: Center(
                        child: RobotoText(
                          value: "Renvoyer",
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      height:48.0,
                      minWidth: 150,
                      onPressed: (){
                        dispatchConfirmSmsEvent(code);
                      },
                      text: "Confirmer",
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.7,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void dispatchConfirmSmsEvent(String code) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<LoginBloc>(context)
        .add(ConfirmSmsEvent(code: code));
  }
}
