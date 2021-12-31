import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:photo_manager/photo_manager.dart';

List<CameraDescription> cameras;
class CameraDisplay extends StatefulWidget {
  final PropertiesModel propertiesModel;
  final String token;
  final bool fromProp;
  const CameraDisplay({Key key, this.propertiesModel, this.token,this.fromProp}) : super(key: key);
  @override
  _CameraDisplayState createState() => _CameraDisplayState();
}

class _CameraDisplayState extends State<CameraDisplay> {
List<AssetPathEntity> list = [];
List<AssetEntity> entities;
bool initialized = false;
CameraController controller;

@override
void initState() {
  init();
  super.initState();
}
@override
void dispose() {
  controller?.dispose();
  super.dispose();
}
@override
Widget build(BuildContext context) {
  String token = widget.token;
  PropertiesModel propertiesModel =widget.propertiesModel;
  return Scaffold(
    body: Column(
      children: [
        CustomAppBar(
          title: "",
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
            onPressed: (){
              //    dispatchGoHomeDisplayEvent();
              print("ok");
            },
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              initialized ? Container(
                  width:  MediaQuery.of(context).size.width,
                  child: CameraPreview(controller))
                  : Center(
                    child: CircularProgressIndicator(
              ),
                  ),
              Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          int sensitivity = 8;
                          if (details.delta.dy > sensitivity) {
                            // Down Swipe
                          } else if (details.delta.dy < -sensitivity) {
                            // Up Swipe
                            dispatchGoTOGalleryEvent(propertiesModel);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.keyboard_arrow_up_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          int sensitivity = 8;
                          if (details.delta.dy > sensitivity) {
                            // Down Swipe
                          } else if (details.delta.dy < -sensitivity) {
                            // Up Swipe
                            //Get.to(GalleryPage(entities: entities));
                            dispatchGoTOGalleryEvent(propertiesModel);
                          }
                        },
                        child: Container(
                          color: Color.fromRGBO(0, 96, 162, .6),
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 10, bottom: 25),
                          padding: EdgeInsets.symmetric(horizontal: 5.5),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: entities == null ? 0 : entities.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 11, horizontal: 5.5),
                                  color: Colors.white,
                                  height: 80,
                                  width: 80,
                                  child: FutureBuilder(
                                    future: entities[i].thumbData,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      final bytes = snapshot.data;
                                      // If we have no data, display a spinner
                                      if (bytes == null)
                                        return CircularProgressIndicator();
                                      // If there's data, display it as an image
                                      return Image.memory(bytes,
                                          fit: BoxFit.cover);
                                    },
                                  ),
                                );
                              }),
                        ),
                      ),
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                iconSize: 25,
                                icon: SvgPicture.asset(
                                  'Assets/Images/opacity.svg',
                                  height: 25,
                                  width: 25,
                                ),
                                onPressed: () {}),
                            IconButton(
                              iconSize: 60,
                              icon: SvgPicture.asset(
                                'Assets/Images/emptyCircle.svg',
                                height: 60,
                                width: 60,
                              ),
                              onPressed: () async {
                                XFile file = await controller.takePicture();
                            //    Get.to(PhotoPreview(file.path));
                                dispatchGoToImageDisplayEvent(File(file.path),propertiesModel);
                              },
                            ),
                            IconButton(
                                iconSize: 25,
                                icon: SvgPicture.asset(
                                  'Assets/Images/refresh.svg',
                                  height: 25,
                                  width: 25,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        )
      ],
    ),
  );
}
void dispatchGoToImageDisplayEvent(File image,PropertiesModel propertiesModel) {
  // Clearing the TextField to prepare it for the next inputted number
  BlocProvider.of<PropertiesBloc>(context)
      .add(GoTOImageDisplayEvent(image: image,propertiesModel: propertiesModel,fromProp: widget.fromProp));
}
void dispatchGoTOGalleryEvent(PropertiesModel propertiesModel) {
  // Clearing the TextField to prepare it for the next inputted number
  BlocProvider.of<PropertiesBloc>(context)
      .add(GoTOGalleryEvent(propertiesModel:propertiesModel,fromProp: widget.fromProp ));
}
init() async {
  list = await PhotoManager.getAssetPathList(onlyAll: true);

  entities = await list.first.getAssetListRange(start: 0, end: 100);
  try {
    cameras = await availableCameras();

  } on CameraException catch (e) {
    print(e.code);
    print( e.description);
  }
  controller = CameraController(cameras[0], ResolutionPreset.high);
  controller.initialize().then((_) {
    if (!mounted) {
      return;
    }
    setState(() {
      initialized = true;
    });
  });
}



}
