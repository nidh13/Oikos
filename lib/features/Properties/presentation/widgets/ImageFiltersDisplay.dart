import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oikosmobile/core/Utils/filter_utils.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customAppBar.dart';
import 'package:image/image.dart'as img;
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_event.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/filtred_image_list_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


import 'filtred_image_widget.dart';

class ImageFilterDisplay extends StatefulWidget {
  File image ;
  final PropertiesModel propertiesModel;
  final bool fromProp;
   ImageFilterDisplay({Key key, this.image,this.propertiesModel,this.fromProp}) : super(key: key);

  @override
  _ImageFilterDisplayState createState() => _ImageFilterDisplayState();
}

class _ImageFilterDisplayState extends State<ImageFilterDisplay> {
  img.Image imageDecoded;
  Filter filter = presetFiltersList.first;
  File filtredImage;
  @override
  void initState() {
    FilterUtils.clearCache();
    filterImage(widget.image);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    File image = widget.image;
    PropertiesModel propertiesModel=widget.propertiesModel;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "",
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace, color: ColorConstant.white),
              onPressed: () async {
                print("k");
                var x = await localPath;
                print(x);
                 var file = File('storage/emulated/0/Pictures/Filtred.jpg');
                dispatchGoToImageDisplayEvent(file,propertiesModel,widget.fromProp);
              },
            ),
            /*action: Row(
              children: [
                InkWell(
                  onTap: (){
                 //   cropImage(image);
                  },
                  child: SvgPicture.asset("Assets/Images/cropIcon.svg",height: 20,width: 20,),
                ),
                SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                    print("ok");
                  },
                  child: SvgPicture.asset("Assets/Images/magicwand.svg",height: 20,width: 20,),
                ),
                SizedBox(width: 15,)
                ,InkWell(
                  onTap: (){
                    setState(() {
                      filter = presetFiltersList[1];
                    });
                  },
                  child: SvgPicture.asset("Assets/Images/pencil.svg",height: 20,width: 20,),
                ),
                SizedBox(width: 10,),
              ],
            ),*/
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(top: 20,right: 40,left: 40),
            child: buildImage(),
          )),
          buildFilters(),
        ],
      ),
    );
  }
  void filterImage(File image){
    final imageBytes =image.readAsBytesSync();
    final newImage = img.decodeImage(imageBytes);
    setState(() {
      imageDecoded = newImage;
    });
  }
  Widget buildImage() {
    const double height = 450;
    if (imageDecoded == null) return Container();

    return FilteredImageWidget(
      filter: filter,
      image: imageDecoded,
      successBuilder: (imageBytes) {
        saveImage(imageBytes);
        return Image.memory(imageBytes, height: height,width: MediaQuery.of(context).size.width, fit: BoxFit.cover);
      },
      errorBuilder: () => Container(height: height,width: MediaQuery.of(context).size.width,),
      loadingBuilder: () => Container(
        height: height,
         width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
  Widget buildFilters() {
    if (imageDecoded == null) return Container();

    return FilteredImageListWidget(

      filters: presetFiltersList,

      image: imageDecoded,
      onChangedFilter: (filter) {
        setState(() {
          this.filter = filter;
        });
      },
    );
  }
  void dispatchGoToImageDisplayEvent(File image,PropertiesModel propertiesModel,bool fromProp) {
    BlocProvider.of<PropertiesBloc>(context)
        .add(GoTOImageDisplayEvent(image: image,propertiesModel: propertiesModel,fromProp: fromProp));
  }
  Future<File> saveImage(List<int> imageBytes) async {
    final result = await ImageGallerySaver.saveImage(
        imageBytes,
        name: "Filtred");
    print(result);

  }

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
  Future<File> get localFile async {
    final dir = await getApplicationDocumentsDirectory();
    final path =  dir.path;
    return File('$path/Filtred.jpg');
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
