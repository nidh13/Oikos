import 'package:flutter/material.dart';
import 'package:oikosmobile/features/Calendar/presentation/pages/calendarProvider.dart';
import 'package:oikosmobile/features/Home/presentation/pages/homeProvider.dart';
import 'package:oikosmobile/features/Message/presentation/pages/messageProvider.dart';
import 'package:oikosmobile/features/Notification/presentation/pages/notificationProvider.dart';
import 'package:oikosmobile/features/Offer/presentation/pages/offerProvider.dart';
import 'package:oikosmobile/features/Profile/presentation/pages/profileProvider.dart';
import 'package:oikosmobile/features/Properties/presentation/pages/propertiesProvider.dart';
import 'package:oikosmobile/features/Service/presentation/pages/serviceProvider.dart';
import 'package:oikosmobile/features/Singin/presentation/pages/signinProvider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case  '/signinProvider':
        return MaterialPageRoute(builder: (_) => SigninProvider(
          fromLogout: settings.arguments,
        ),
        );
      case  '/homeProvider':
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => HomeProvider(
          user: map['user'],
          token: map['token'],
         // fromAppBar: map['fromAppBar'],
          listProp: map['listProp'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
          },
        );
      case  '/ProfileProvider':
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ProfileProvider(
          user: map['user'],
          token: map['token'],
          fromAppBar: map['fromAppBar'],
          listProp: map['listProp'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case  '/MessageProvider':
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => MessageProvider(
          user: map['user'],
          token: map['token'],
          listProp: map['listProp'],
          sendMessage: map['sendMessage'],
          sender: map['sender'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case  '/ServiceProvider':
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ServiceProvider(
          user: map['user'],
          token: map['token'],
          listProp: map['listProp'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case  '/NotificationProvider':
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => NotificationProvider(
          user: map['user'],
          token: map['token'],
          listProp: map['listProp'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case  '/BienProvider':
        //final map = settings.arguments as Map<String, dynamic>;
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => PropertiesProvider(
         fromAppBar: map['fromAppBar'],
          user: map['user'],
          token: map['token'],
          listProp: map['listProp'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case  '/CalendarProvider':
      //final map = settings.arguments as Map<String, dynamic>;
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => CalendarProvider(
          user: map['user'],
          token: map['token'],
          listProp: map['listProp'],
          propertiesModel: map['propertiesModel'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      case  '/OfferProvider':
      //final map = settings.arguments as Map<String, dynamic>;
        final map = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => OfferProvider(
          user: map['user'],
          token: map['token'],
          listProp: map['listProp'],
          propertiesModel: map['propertiesModel'],
        ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'label_error',
                    style: TextStyle(
                      fontSize: 80.0,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'label_errormsg',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
