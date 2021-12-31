import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/core/Utils/customBar.dart';
import 'package:oikosmobile/core/Utils/customButton.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/core/Utils/imagCard.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/afterEstimation.dart';

class DeleteImagesDisplay extends StatefulWidget {
  final PropertiesModel propertiesModel;
  final String token ;
  final bool fromProp ;
  const DeleteImagesDisplay({Key key, this.propertiesModel, this.token,this.fromProp}) : super(key: key);
  @override
  _DeleteImagesDisplayState createState() => _DeleteImagesDisplayState();
}

class _DeleteImagesDisplayState extends State<DeleteImagesDisplay> {
  List<int>selectedItems =[];
  int _groupeValue=0;
  bool popUp = false;
  void selectAll( ){
    for(int i =0;i<widget.propertiesModel.fileBien.length;i++){
      if(!selectedItems.contains(i)){
        selectedItems.add(i);

      }
    }
  }
  void diSelectAll( ){
    for(int i =0;i<widget.propertiesModel.fileBien.length;i++){
      if(selectedItems.contains(i)){
        selectedItems.removeWhere((element) => element == i);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PropertiesModel propertiesModel =widget.propertiesModel;
    String token = widget.token;
    bool fromProp=widget.fromProp ;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: "les photos de bien".toUpperCase(),
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
                  onPressed: (){
                    //    dispatchGoHomeDisplayEvent();
                    print("ok");
                  },
                ),
                action: PopupMenuButton<String>(
                  padding: EdgeInsets.only(left: 30),
                  icon: SvgPicture.asset("Assets/Images/menudotsverticalIcon.svg",height: 20,width: 20,),
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Retouche automatisé','Home staging virtuel'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: CustomText(
                          value: choice,
                          color: ColorConstant.darkText,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList();
                  },
                ),
                /*InkWell(
              onTap: (){
                print("ok");
              },
              child: SvgPicture.asset("Assets/Images/menudotsverticalIcon.svg",height: 20,width: 20,),
            ),*/
              ),
              CustomBar(
                firstLine: propertiesModel.typeofprop+" - "+propertiesModel.nbRooms.toString()+" Pièces - "+propertiesModel.allArea.round().toString()+" m²",
                secondLine: "10 rue AlbertMat - Virigneux 42140",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30,top: 10),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: 1,
                                  activeColor: ColorConstant.primaryColor,
                                  groupValue: _groupeValue,
                                  onChanged: (value){
                                  },

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10,left: 10),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(_groupeValue== 0){
                                          _groupeValue =1;
                                          selectAll();
                                        }else{
                                          _groupeValue =0;
                                          diSelectAll();
                                        }
                                      });
                                    },
                                    child: Container(height: 20,width: 20,),
                                  ),
                                )
                              ],
                            ),
                            CustomText(
                              value: "TOUT",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.darkText,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: GridView.builder(
                          itemCount: propertiesModel.fileBien.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: (){
                                  setState(() {
                                    if(selectedItems.contains(index)){
                                      selectedItems.removeWhere((element) => element == index);
                                    }else{
                                      selectedItems.add(index);
                                    }
                                  });
                                },
                                child:  Stack(
                                  children: [
                                    Container(
                                        height: 177,
                                        width: 177,
                                        decoration: BoxDecoration(
                                            border: selectedItems.contains(index) ?Border.all(
                                                color: Color(0xff1EC501), width: 3):Border.all(
                                                color: Colors.transparent, width: 3)
                                        ),
                                        child: ImageCard(imageId: propertiesModel.fileBien[index].id,height: 174,width: 174,token: token,)
                                    ),
                                    selectedItems.contains(index)?Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Color(0xff1EC501),
                                      ),
                                    ):Positioned(
                                        right: 10,
                                        top: 12,
                                        child: Container(
                                          height: 18,
                                          width: 18,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ))
                                  ],
                                )
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                color: Color(0xff0060A2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'annuler'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Multi',
                            height: 1.1,
                            letterSpacing: 0.77,
                          ),
                        )),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          popUp = true;
                        });
                      },
                      child: Text(
                        'Supprimer'.toUpperCase(),
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
                  ],
                ),
              )
            ],
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
                decoration: BoxDecoration(
                  color:  ColorConstant.blueLoading,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    //  _loadPicker(ImageSource.gallery);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: 270,
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("Assets/Images/Groupe 656.svg",),
                        Material(
                          type: MaterialType.transparency,
                          child: CustomText(
                            value:  "Vous-vous vraiment supprimez\nces photos ?",
                            color: ColorConstant.darkText,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              text: "OUI",
                              fontWeight:FontWeight.w800,
                              fontSize: 11,
                              letterSpacing: 0.7,
                              height: 48,
                              onPressed: (){
                                dispatchDeleteImagesEventEvent(propertiesModel,getSelectedImagesId(propertiesModel),token,fromProp);
                              },
                              minWidth: 135,
                            ),
                            GestureDetector(
                              onTap: (){
                                // _loadPicker(ImageSource.camera);
                              },
                              child: Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: CustomText(
                                    value: "NON, MERCI",
                                    color: ColorConstant.primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                  ),
                ),
              ),
            )
          ],
        ):Container(),
      ],
    );
  }
  List<String>getSelectedImagesId(PropertiesModel propertiesModel){
    List<String> list =[];
    for(int i= 0;i<selectedItems.length; i++){
      list.add(propertiesModel.fileBien[selectedItems[i]].id);
    }
    return list;
  }
  void handleClick(String value) {
    switch (value) {
      case 'Retouche automatisé': print("Retouche automatisé");
      break;
      case 'Home staging virtuel': print("Home staging virtuel");
      break;
    }
  }

  void dispatchDeleteImagesEventEvent(PropertiesModel propertiesModel,List<String> listId,String token,bool fromProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(DeleteImagesEvent(propertiesModel: propertiesModel,listId:listId,token: token,fromProp: fromProp));
  }
}
