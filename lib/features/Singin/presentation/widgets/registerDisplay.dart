import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBackground.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customInput.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/inputChecker.dart';
import 'package:oikosmobile/core/Utils/socialMediaWidget.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_bloc.dart';
import 'package:oikosmobile/features/Singin/presentation/bloc/login_event.dart';

class RegisterDisplay extends StatefulWidget {
 final List<String> departments;
 final String message;
  const RegisterDisplay({
    Key key,
    this.departments,this.message
  }) : super(key: key);
  @override
  _RegisterDisplayState createState() => _RegisterDisplayState();
}

class _RegisterDisplayState extends State<RegisterDisplay> {
  final myController = TextEditingController();
  String valueChoose;
  DateTime pickedDate;
  List listItem ;
  bool _passwordVisible ;
  bool checkerPassword = true;
  bool popUp = false;
  String nom;
  ValidName validfName=ValidName(message: "",valid: false);
  String prenom;
  ValidName validLName=ValidName(message: "",valid: false);
  String password;
  String email;
  ValidName validEmail=ValidName(message: "",valid: false);
  String phoneNumber;
  ValidName validPhoneNumber=ValidName(message: "",valid: false);
  String street;
  ValidName validAddress=ValidName(message: "",valid: false);
  String zipCode;
  ValidName validZipCode=ValidName(message: "",valid: false);
  String birthDate;
  bool is_8char = false,
      isspecialcar = false,
      is1upper = true,
      is1number = false;
  validPassword2(String value) {
    RegExp numberRegex = RegExp(onedigit);
    RegExp uppercaseRegex = RegExp(uppercasePattern);
    RegExp specialRegex = RegExp(specialCaracPattern);

    if (value.length > 7) {
      setState(() {
        is_8char = true;
      });
    } else {
      setState(() {
        is_8char = false;
      });
    }
    if (numberRegex.hasMatch(value)) {
      setState(() {
        is1number = true;
      });
    } else {
      setState(() {
        is1number = false;
      });
    }
    if (uppercaseRegex.hasMatch(value)) {
      setState(() {
        is1upper = true;
      });
    } else {
      setState(() {
        is1upper = false;
      });
    }
    if (specialRegex.hasMatch(value)) {
      setState(() {
        isspecialcar = true;
      });
    } else {
      setState(() {
        isspecialcar = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    birthDate =formatDate(DateTime.now());
    print(birthDate);
    _passwordVisible = false;
    listItem = widget.departments;
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(height: 40,),
                        Padding(
                          padding: EdgeInsets.only(bottom:30),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  CustomImput(
                                    labelText: "Nom",
                                    hintText: "Taper votre nom",
                                    textInputType: TextInputType.visiblePassword,
                                    initialValue: nom,
                                    onChanged: (value){
                                      setState(() {
                                        nom = value;
                                        validfName=  validfNameMessage(nom,"Nom");
                                      });
                                    },
                                  ),
                                  validfName.valid
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      value: validfName.message,
                                      color: ColorConstant.red,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:8,
                              ),
                              Column(
                                children: [
                                  CustomImput(
                                    labelText: "Prénom",
                                    hintText: "Taper votre Prénom",
                                    textInputType: TextInputType.visiblePassword,
                                    initialValue: prenom,
                                    onChanged: (value){
                                      setState(() {
                                        prenom = value;
                                        validLName=  validfNameMessage(prenom,"Prénom");
                                      });
                                    },
                                  ),
                                  validLName.valid
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      value: validLName.message,
                                      color: ColorConstant.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:8,
                              ),
                              Column(
                                children: [
                                  CustomImput(
                                    labelText: "Email",
                                    hintText: "Taper votre email",
                                    textInputType: TextInputType.visiblePassword,
                                    initialValue: email,
                                    onChanged: (value){
                                      setState(() {
                                        email = value;
                                        validEmail = validEmailMessage(email,"email");
                                      });
                                    },
                                  ),
                                  validEmail.valid
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      value: validEmail.message,
                                      color: ColorConstant.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:8,
                              ),
                              Column(
                                children: [
                                  CustomImput(
                                    labelText: "Mot de passe",
                                    hintText: "Taper votre mot de passe",
                                    textInputType: TextInputType.visiblePassword,
                                    initialValue: password,
                                    obscureText: !_passwordVisible,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ?Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: ColorConstant.suffixIcon,
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        password = value;
                                        checkerPassword = regExpPassword.hasMatch(password);
                                        validPassword2(value);
                                      });
                                    },
                                  ),
                                  checkerPassword && is1upper
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 5.0,right: 20,left: 40),
                                    child: Center(
                                        child: RichText(
                                          textScaleFactor: 1.0,
                                          text: TextSpan(
                                              text: "Le mot de passe doit contenir ",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'Multi',
                                                color: ColorConstant.red,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: " 8 charactéres ,",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'Multi',
                                                      fontWeight: FontWeight.w700,
                                                      color: is_8char
                                                          ? Color(0xff23CE6B)
                                                          : ColorConstant.red,
                                                    )),
                                                TextSpan(
                                                    text: "un charctere majuscule ",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'Multi',
                                                      fontWeight: FontWeight.w700,
                                                      color: is1upper
                                                          ? Color(0xff23CE6B)
                                                          : ColorConstant.red,
                                                    )),
                                                new TextSpan(
                                                    text: ",un numéro et ",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'Multi',
                                                      fontWeight: FontWeight.w700,
                                                      color: is1number
                                                          ? Color(0xff23CE6B)
                                                          : ColorConstant.red,
                                                    )),
                                                new TextSpan(
                                                  text: "un charactére spécilae.",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Multi',
                                                    color: isspecialcar
                                                        ? Color(0xff23CE6B)
                                                        : ColorConstant.red,
                                                  ),
                                                ),
                                              ]),
                                        )),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Center(
                          child: CustomText(
                            value: "Informations Personnelles",
                            textAlign:TextAlign.center,
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:30),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    color: ColorConstant.white,
                                    value: "Date de Naissance",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  SizedBox(height: 3,),
                                  InkWell(
                                    onTap: _pickDate,
                                    child: Container(
                                      height: 48,
                                      width: 307,
                                      padding: EdgeInsets.only(left:20 ,right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        color: ColorConstant.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
                                            style: TextStyle(
                                              fontFamily: 'Multi',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14 ,
                                              color: ColorConstant.dark ,

                                            ),
                                          ),
                                          Icon(
                                            Icons.date_range_outlined,
                                            color: ColorConstant.suffixIcon,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:8,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    CustomText(
                                      color: ColorConstant.white,
                                      value: "Région",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                    SizedBox(height: 3,),
                                    Container(
                                      height: 48,
                                      width: 307,
                                      padding: EdgeInsets.only(
                                          left: 20,right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        color: ColorConstant.white,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("Région",
                                            style: TextStyle(
                                              fontFamily: 'Multi',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14 ,
                                              color: ColorConstant.dark ,
                                            ),
                                          ),
                                          dropdownColor: ColorConstant.white,
                                          value: valueChoose,
                                          icon: Icon(Icons.arrow_drop_down,color: ColorConstant.suffixIcon,),
                                          iconSize: 36,
                                          isExpanded: true,
                                          style: TextStyle(
                                            fontFamily: 'Multi',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14 ,
                                            color: ColorConstant.dark ,
                                          ),

                                          onChanged: (newValue){
                                            setState(() {
                                              valueChoose=newValue;
                                            });
                                          },
                                          items: listItem.map((valueItem){
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                              SizedBox(
                                height:8,
                              ),
                              Column(
                                children: [
                                  CustomImput(
                                    labelText: "Adresse Postale",
                                    hintText: "Taper votre Adresse postale",
                                    textInputType: TextInputType.visiblePassword,
                                    initialValue: street,
                                    onChanged: (value){
                                      setState(() {
                                        street = value;
                                        validAddress = validAddressMessage(street,"adresse postale");
                                      });
                                    },
                                  ),
                                  validAddress.valid
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      value: validAddress.message,
                                      color: ColorConstant.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:8,
                              ),
                              Column(
                                children: [
                                  CustomImput(
                                    labelText: "Code Postale",
                                    hintText: "Taper votre code postale",
                                    textInputType: TextInputType.number,
                                    initialValue: zipCode,
                                    onChanged: (value){
                                      setState(() {
                                        zipCode =value;
                                        validZipCode = validZipCodeMessage(zipCode,"adresse postale");
                                      });
                                    },
                                  ),
                                  validZipCode.valid
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      value: validZipCode.message,
                                      color: ColorConstant.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:8,
                              ),
                              Column(
                                children: [
                                  CustomImput(
                                    labelText: "Téléphone",
                                    hintText: "Taper votre téléphone",
                                    textInputType: TextInputType.phone,
                                    initialValue: phoneNumber,
                                    onChanged: (value){
                                      phoneNumber = value;
                                      setState(() {
                                        validPhoneNumber = validZipCodeMessage(phoneNumber,"téléphone");
                                      });
                                    },
                                  ),
                                  validPhoneNumber.valid
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      value: validPhoneNumber.message,
                                      color: ColorConstant.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only( top: 87,bottom:62 ),
                                child: CustomButton(
                                  height: 48.0,
                                  minWidth: 299,
                                  onPressed: (){
                                    if(checkerPassword&&validEmail.valid&&validLName.valid
                                        &&validfName.valid&&validAddress.valid&&validPhoneNumber.valid
                                        &&validZipCode.valid&&password!=null&&nom!=null&&prenom!=null
                                        &&street!=null&&zipCode!=null&&email!=null&&phoneNumber!=null&&valueChoose!=null){
                                      dispatchRegistre(email, password, phoneNumber, birthDate, street, zipCode, nom, prenom, listItem.indexOf(valueChoose)+1,widget.departments);
                                    }
                                  },
                                  text: "CONTINUER",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.7,
                                ),
                              ),
                              SocialMediaWidget(
                                onPressedGoogle: (){},
                                onPressedFacebook: (){},
                              ),
                              SizedBox(height: 47,)

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )

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
                  width: 300,
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
  void dispatchGoToWelcomEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<LoginBloc>(context)
        .add(GotoWelcomEvent());
  }
  void dispatchRegistre(String email, String password,String phoneNumber,String birthDate,String street,String zipCode,
      String lastName,String firstName,int departmentNumber,List<String> departments) {
    BlocProvider.of<LoginBloc>(context).add(SignupEvent(
      email: email,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      street: street,
      zipCode: zipCode,
      departmentNumber: departmentNumber,
      password: password,
      lastName: lastName,
      firstName: firstName,
      departments: departments
    ));
  }

  void _pickDate() async{
    String month;
    String day ;
   DateTime date = await showDatePicker(
     context: context,

     firstDate: DateTime(DateTime.now().year-100),
     lastDate: DateTime(DateTime.now().year+1),
     initialDate: DateTime.now(),
    );
   if(date!= null){
     if(pickedDate.month<10){
         month = "0${pickedDate.month}";
     }else{
       month = "${pickedDate.month}";
     }
     if(pickedDate.day<10){
       day = "0${pickedDate.day}";
     }else{
       day = "${pickedDate.day}";
     }
     setState(() {
       pickedDate =date;
       birthDate ="${pickedDate.year}-"+month+"-"+day;
       print(birthDate);

     });
   }
  }
  String formatDate(DateTime dateTime){
    String month;
    String day ;
    String date;
    if(dateTime.month<10){
      month = "0${dateTime.month}";
    }else{
      month = "${dateTime.month}";
    }
    if(dateTime.day<10){
      day = "0${dateTime.day}";
    }else{
      day = "${dateTime.day}";
    }
    date ="${dateTime.year}-"+month+"-"+day;
    return date;
  }
  String ErrorFromMessage(String message){
    if(message.contains("Email is already in use")){
      return "email est dija utilisé !";
    }
    if(message.contains("Phone Number already in use")){
      return "numéro de télephone est dija utilisé !";
    }
  }
}
