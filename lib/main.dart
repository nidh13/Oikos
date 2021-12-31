import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/injection_container.dart'as sl;

import 'core/Routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sl.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OIKOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Multi',
        primaryColor: ColorConstant.primaryColor,
      ),
      initialRoute: '/signinProvider',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

