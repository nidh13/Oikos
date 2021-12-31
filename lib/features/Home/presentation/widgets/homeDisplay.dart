import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class HomeDisplay extends StatefulWidget {
  final User user;
  final String token;
  final List<PropertiesModel>listProp;

  const HomeDisplay({Key key, this.user, this.token, this.listProp}) : super(key: key);
  @override
  _HomeDisplayState createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  @override
  Widget build(BuildContext context) {
     User user=widget.user;
     String token=widget.token;
     List<PropertiesModel>listProp=widget.listProp;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(index: 0,token: token,user: user,listProp: listProp,),
      body: Center(
        child: Text("Home"),
      ),
    );;
  }
}
