import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oikosmobile/core/Utils/RobotoText.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customBlueAppBar.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/Utils/servicesId.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_bloc.dart';
import 'package:oikosmobile/features/Service/presentation/bloc/service_event.dart';
import 'package:http/http.dart' as http;

class PickPropInformation extends StatefulWidget {
  final FullCalendarDay date ;
  final String time;
  final Pack pack;
  final List<Pack>packs;
  final String token;

  const PickPropInformation({Key key, this.date, this.time, this.pack, this.packs,this.token}) : super(key: key);

  @override
  _PickPropInformationState createState() => _PickPropInformationState();
}

class _PickPropInformationState extends State<PickPropInformation> {
  Map<String, dynamic> paymentIntentData;
  Color bax;
  Color border;
  Color text;
  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FullCalendarDay date=widget.date ;
    String time=widget.time;
    Pack pack =widget.pack;
    List<Pack> packs =widget.packs;
    return Stack(
      children: [
        Scaffold(body: Column(children: [
          CustomBlueAppBar(
            title: "Payement".toUpperCase(),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: (){
                dispatchGoToPickTimeEvent(date);
                print("ok");
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Container(
                  height: 151,
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bax,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Color.fromRGBO(0, 0, 0, 0.09),
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: border,width: 3),
                      color: bax,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RobotoText(
                          value: "Pack "+pack.rang.toString()+" / € "+pack.amount.toString(),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          value: pack.desc1,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.white,
                        ),
                        CustomText(
                          value: pack.desc2,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset("Assets/Images/amountblue.svg",width: 46,height: 46,),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        value: date.dayName+" / "+date.day.toString()+date.monthName+" "+date.year.toString()+" / "+time,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: ColorConstant.dark,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(children: [
                    SvgPicture.asset("Assets/Images/blueLocation.svg",width: 46,height: 46,),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      value: "Montant totale à payer (TTC) 320 €",
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: ColorConstant.dark,
                    ),
                  ],),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            color: Color(0xFF5FAEE5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                      });
                    },
                    child: Text(
                      'Annuler'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Multi',
                        height: 1.1,
                        letterSpacing: 0.77,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: InkWell(
                    onTap: ()async{
                      await makePayment();
                    },
                    child: Text(
                      'Payer'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Multi',
                        height: 1.1,
                        letterSpacing: 0.77,
                      ),
                    ),
                  ),
                ),
                /*TextButton(
                  onPressed: () {
                    dispatchGoToPropInformationDisplayEvent();
                  },
                  child: Text(
                    'Suivant'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Multi',
                      height: 1.1,
                      letterSpacing: 0.77,
                    ),
                  ),
                ),*/
              ],
            ),
          )
        ],
        ),)
      ],
    );
  }
  Future<void> makePayment() async {
    var price = widget.pack.amount;
    try {
      paymentIntentData =
      await createPaymentIntent(price.toString(), 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: 'ANNIE')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData['client_secret'],
            confirmPayment: true,
          )).then((newValue){


        print('payment intent'+paymentIntentData['id'].toString());
        print('payment intent'+paymentIntentData['client_secret'].toString());
        print('payment intent'+paymentIntentData['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
        PayParams payParams =PayParams(token: widget.token,id: ServicesId.SEANCE_PHOTO);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paiement effectué avec succès")));
        dispatchPayPhotoServiceEvent(payParams);

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51JyO7uBeozUEAEmF6YFc4tk6nWPPaY9Twy2WYnVlT8cvAYKgZfWlGaqLXLeWOr3jHssFdX1gTPiSYuHnSItCDLxe009UjjJorp',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }

  void init(){
    switch(widget.pack.rang){
      case 1 :
        bax =Color(0xFF7DD3FC);
        border =Color(0xFF45BFF9);
        text = Color(0xFF12A1E5);
        break;
      case 2 :
        bax =Color(0xFFFF9ED5);
        border =Color(0xFFE177B3);
        text = Color(0xFFBC548F);
        break;
      case 3 :
        bax =Color(0xFF54D4B7);
        border =Color(0xFF2DBB9B);
        text = Color(0xFF2DA58A);
        break;
    }
  }
  void dispatchGoToPickTimeEvent(FullCalendarDay date) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPickTimeEvent(date: date,pack: widget.pack,packs: widget.packs));
  }
  void dispatchGoToPropInformationDisplayEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(GoToPropInformationDisplayEvent());
  }
  void dispatchInitialServiceEvent() {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(InitialServiceEvent());
  }
  void dispatchPayPhotoServiceEvent(PayParams payParams) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<ServiceBloc>(context)
        .add(PayPhotoServiceEvent(payParams: payParams));
  }
}
