import 'package:flutter/material.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/custombottomNavBar.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class LoadingAppBarWidget extends StatefulWidget {
  final PropertiesModel propertiesModel;
  final String token ;
  final List<PropertiesModel>listProp;
  final User user;

  const LoadingAppBarWidget({Key key, this.propertiesModel, this.token, this.listProp, this.user}) : super(key: key);
  @override
  _LoadingAppBarWidgetState createState() => _LoadingAppBarWidgetState();
}

class _LoadingAppBarWidgetState extends State<LoadingAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    PropertiesModel propertiesModel =widget.propertiesModel;
    List<PropertiesModel>listProp=widget.listProp;
    User user =widget.user;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(token: token,user: user,listProp: listProp,),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            ColorConstant.primaryColor,
          ),
        ),
      ),
    );
  }
}
