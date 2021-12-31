import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBackground.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customInput.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/inputChecker.dart';
import 'package:oikosmobile/features/Profile/presentation/bloc/bloc.dart';
import 'package:oikosmobile/features/Singin/data/models/generalInformation_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:table_calendar/table_calendar.dart';

class UpdateProfile extends StatefulWidget {
  final List<String> departments;
  final User user;
  final String token;

  const UpdateProfile({Key key, this.departments,this.user,this.token}) : super(key: key);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String valueChoose;
  String maritalStatus;
  String sex;
  DateTime pickedDate;
  bool selected = false;
  List listItem ;
  List listMaritalStatus =["Celibataire", "Marie", "Pascse", "Divorce", "Veuf"] ;
  List listSex =["Monsieur", "Madame"];
  bool _passwordVisible ;
  String nom;
  String prenom;
  String password;
  String email;
  String phoneNumber;
  String street;
  String zipCode;
  String birthDate;
  DateTime defaultBirthDate;
  ValidName validfName=ValidName(message: "",valid: false);
  ValidName validLName=ValidName(message: "",valid: false);
  ValidName validEmail=ValidName(message: "",valid: false);
  bool checkerPassword = true;
  ValidName validPhoneNumber=ValidName(message: "",valid: false);
  List<CalendarYear> years;
  //List<CalendarDay> days;
  List<CalendarMonth>listMonths;
  int indexMonth =0;
  int position=0;
  List<Time>listTimes =[Time(title: "09:00 AM",selected: false),Time(title: "10:30 AM",selected: false),
    Time(title: "12:00 PM",selected: false),Time(title: "14:00 PM",selected: false),
    Time(title: "15:30 PM",selected: false),Time(title: "17:00 PM",selected: false)];
  final ScrollController _scrollController = ScrollController();

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
    _passwordVisible = false;
    listItem = widget.departments;
    nom = widget.user.firstName;
    prenom =widget.user.lastName;
    email = widget.user.email;
    phoneNumber =widget.user.phoneNumber;
    street = widget.user.street;
    zipCode =widget.user.zipCode;
    birthDate=widget.user.birthDate;
    valueChoose =widget.user.departmentNumber;
    defaultBirthDate = birthdateConvert(birthDate=widget.user.birthDate);
    pickedDate =defaultBirthDate;
    if(widget.user.maritalStatus!= null){
      maritalStatus =maritalStatusFromUser(widget.user.maritalStatus);
    }
    if(widget.user.civility!=null){
      sex= sexFromUser(widget.user.civility);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    return Scaffold(
      body: CustomBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: CustomText(
                fontSize: 14,
                color: ColorConstant.white,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w700,
                value: "MON PROFIL",
              ),
              elevation: 0.0,
              leading: BackButton(
                color: ColorConstant.white,
                onPressed: () {
               dispatchGoToFirstPageEvent();
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
                                //  hintText: "John Doe",
                                textInputType: TextInputType.visiblePassword,
                                initialValue: nom,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      Icons.person_outline_outlined
                                  ),
                                ),
                                onChanged: (value){
                                  nom = value;
                                  setState(() {
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
                                //  hintText: "John Doe",
                                textInputType: TextInputType.visiblePassword,
                                initialValue: prenom,
                                onChanged: (value){
                                  prenom = value;
                                  setState(() {
                                    validLName=  validfNameMessage(prenom,"Prénom");
                                  });
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      Icons.person_outline_outlined
                                  ),
                                ),
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
                                //     hintText: "johndoe@mail.com",
                                textInputType: TextInputType.visiblePassword,
                                initialValue: email,
                                onChanged: (value){
                                  email =value;
                                  setState(() {
                                    validEmail = validEmailMessage(email,"email");
                                  });
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      Icons.mail_outline
                                  ),
                                ),
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
                                labelText: "Téléphone",
                                //   hintText: "09 84 17 34 77",
                                textInputType: TextInputType.phone,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      Icons.phone
                                  ),
                                ),
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
                          SizedBox(
                            height:8,
                          ),
                          Column(
                            children: [
                              CustomImput(
                                labelText: "Nouveau Mot de passe",
                                //  hintText: "Doe-45*mo)=",
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
                                  password =value;
                                  setState(() {
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
                          SizedBox(
                            height:8,
                          ),
                          Padding(
                            padding:  EdgeInsets.only( top: 30,bottom:40 ),
                            child: CustomButton(
                              height: 48.0,
                              minWidth: 299,
                              onPressed: (){
                                dispatchUpdateProfileEvent(token,email,password,phoneNumber,nom,prenom);
                              },
                              text: "Enregistrer".toUpperCase(),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                            ),
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
                          CustomImput(
                            labelText: "Adresse Postale",
                            //   hintText: "31 Avenue Raymond Poincaré",
                            textInputType: TextInputType.visiblePassword,
                            initialValue: street,
                            onChanged: (value){
                              street = value;
                            },
                          ),
                          SizedBox(
                            height:8,
                          ),
                          CustomImput(
                            labelText: "Code Postale",
                            //   hintText: "75116",
                            textInputType: TextInputType.number,
                            initialValue: zipCode,
                            onChanged: (value){
                              zipCode =value;
                            },
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
                                  value: "Statut",
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
                                      hint: Text("Statut",
                                        style: TextStyle(
                                          fontFamily: 'Multi',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 ,
                                          color: ColorConstant.dark ,
                                        ),
                                      ),
                                      dropdownColor: ColorConstant.white,
                                      value: maritalStatus,
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
                                          maritalStatus=newValue;
                                        });
                                      },
                                      items: listMaritalStatus.map((valueItem){
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                CustomText(
                                  color: ColorConstant.white,
                                  value: "Sexe",
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
                                      hint: Text("Sexe",
                                        style: TextStyle(
                                          fontFamily: 'Multi',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 ,
                                          color: ColorConstant.dark ,
                                        ),
                                      ),
                                      dropdownColor: ColorConstant.white,
                                      value: sex,
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
                                          sex=newValue;
                                        });
                                      },
                                      items: listSex.map((valueItem){
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
                          Padding(
                            padding:  EdgeInsets.only( top: 30,bottom:40 ),
                            child: CustomButton(
                              height: 48.0,
                              minWidth: 299,
                              onPressed: (){
                                var adress = Address(
                                  zipCode: zipCode,
                                  street: street,
                                  departmentIdentifier: listItem.indexOf(valueChoose)+1
                                );
                                var generalInformationModel =GeneralInformationModel(
                                  address: adress,
                                  birthDate: birthDate,
                                  civility: sex.toUpperCase(),
                                  maritalStatus: maritalStatus.toUpperCase()
                                );
                                dispatchUpdateGeneralInformationEvent(token,generalInformationModel );
                              },
                              text: "Enregistrer".toUpperCase(),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                            ),
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
    );
  }
  void _pickDate() async{
    String month;
    String day ;
    DateTime date = await showDatePicker(
      context: context,

      firstDate: DateTime(DateTime.now().year-100),
      lastDate: DateTime(DateTime.now().year+1),
      initialDate: defaultBirthDate,
    );
    if(date!= null){
      if(date.month<10){
        month = "0${date.month}";
      }else{
        month = "${date.month}";
      }
      if(date.day<10){
        day = "0${date.day}";
      }else{
        day = "${date.day}";
      }
      setState(() {
        pickedDate =date;
        birthDate ="${date.year}-"+month+"-"+day;

      });
    }
  }
  String maritalStatusFromUser(String maritalStatus){
    switch(maritalStatus){
      case "CELIBATAIRE":return "Celibataire";
      break;
      case "MARIE":return "Marie";
    break;
    case "PASCSE":return "Pascse";
    break;
    case "DIVORCE":return "Divorce";
    break;
    case "VEUF":return "Veuf";
    break;
    }
  }
  String sexFromUser(String sex){
    switch(sex){
      case "MONSIEUR":return "Monsieur";
      break;
      case "MADAME":return "Madame";
      break;
    }
  }
  DateTime birthdateConvert(String birthdate){
    int year = int.parse(birthdate.substring(0, 4));
    int month = int.parse(birthdate.substring(5, 7));
    int day = int.parse(birthdate.substring(8, birthdate.length));
    DateTime time = new DateTime(year,month,day);
    print(time);
    return time;
  }
  void dispatchUpdateProfileEvent(String token,String email, String password,String phoneNumber, String lastName,String firstName) {
    BlocProvider.of<ProfileBloc>(context).add(UpdateProfileEvent(
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      lastName: lastName,
      firstName: firstName,
      token: token
    ));
  }
  void dispatchUpdateGeneralInformationEvent(String token,GeneralInformationModel generalInformationModel) {
    BlocProvider.of<ProfileBloc>(context).add(UpdateGeneralInformationEvent(token: token,generalInformationModel:generalInformationModel));
  }
  void dispatchGoToFirstPageEvent() {
    BlocProvider.of<ProfileBloc>(context).add(GoToFirstPageEvent());
  }
}