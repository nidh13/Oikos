import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oikosmobile/core/Utils/loadingAppBarWidget.dart';
import 'package:oikosmobile/core/Utils/loadingWidget.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_bloc.dart';
import 'package:oikosmobile/features/Properties/presentation/bloc/properties_state.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/ImageFiltersDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/adTextDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/addPropertiesDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/afterEstimation.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/cameraDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/deleteImagesDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/gallery.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/imageDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/imagesSavedDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/propertieDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/propertieImageDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/propertiesBeforeEstimation.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/propertiesDisplay.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/estimationResult.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/updateProprtiesDisplay.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';


class PropertiesPage extends StatelessWidget {
  final User user;
  final String token ;
  final List<PropertiesModel>listProp;
 // bool fromHome ;
  PropertiesPage({Key key, this.user,this.token,this.listProp}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertiesBloc, PropertiesState>(
        builder: (context,state){

          if(state is GoTOAddPropertiesState){
            return AddPropertiesDisplay(token: token,user: user,listTypesOfProperties: state.listTypesOfProperties,listProp:listProp,);
          }
          if(state is FirstPageState){
            return PropertiesDisplay(user: user,token: token,listProp: state.listProp,);
          }
          if(state is GoToGoHomeDisplayState){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(
                '/homeProvider',
                  arguments: {
                    'user':state.user,
                    'token':state.token,
                    'listProp':listProp
                  }
              );
            });
          }
          if(state is AddPropertiesLoadedState){
            return PropertiesBeforeEstimation(user: user,token: token,propertiesModel: state.propertiesModel,listProp: state.listProp,);
          }
          if(state is EstimationPropertiesLoadedState){
            return EstimationResult(propertiesModel: state.propertiesModel,estimationList:state.estimationList,token: token,user: user,listProp: state.listProp,);
          }
          if(state is ValidateEstimationState){
            return AfterEstimation(propertiesModel: state.propertiesModel,token: token,listProp:state.listProp,user: user,);
          }if(state is GalleryState){
            return Gallery(propertiesModel: state.propertiesModel,token: token,fromProp: state.fromProp,);
          }
          if(state is ImageDisplayState){
            return ImageDisplay(image: state.image,token: token,propertiesModel: state.propertiesModel,fromProp: state.fromProp,);
          }
          if(state is PropertiesImagesDisplayState){
            return PropertiesImageDisplay(token: token,propertiesModel: state.propertiesModel,fromProp: state.fromProp,);
          }
          if(state is DeleteImagesState){
            return DeleteImagesDisplay(token: token,propertiesModel: state.propertiesModel,fromProp: state.fromProp,);
          }
          if(state is ImagesSavedState){
            return ImagesSavedDisplay(token: token,propertiesModel: state.propertiesModel,listProp: state.listProp,user: user,);
          }
          if(state is AdTextState){
            return AdTextDisplay(propertiesModel: state.propertiesModel,token: token,);
          }
          if(state is PropertieDisplayState){
            return PropertieDisplay(token: token,propertiesModel: state.propertiesModel,listProp:state.listProp,user: user,calendar: state.calendar,);
          }

          if(state is CameraState){
            return CameraDisplay(token: token,propertiesModel: state.propertiesModel,fromProp: state.fromProp,);
          }
          if(state is FilterImageState){
            print(state.propertiesModel);
            return ImageFilterDisplay(image: state.image,propertiesModel: state.propertiesModel,fromProp:state.fromProp,);
          }
          if(state is CreateCalendarState){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(
                  '/CalendarProvider',
                  arguments: {
                    'user':user,
                    'token':token,
                    'listProp':state.listProp,
                    'propertiesModel':state.propertiesModel,
                  }
              );
            });
          }
          if(state is LoadingState){
            return LoadingAppBarWidget(token: token,user: user,listProp:listProp,);
          }
          if(state is GoToUpdatePropertiesState){
            return UpdatePropertiesDisplay(token: token,user: user,listProp:listProp,propertiesModel: state.propertiesModel,);
          }
          if(state is GoToListOffersState){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(
                  '/OfferProvider',
                  arguments: {
                    'user':user,
                    'token':token,
                    'listProp':state.listProp,
                    'propertiesModel':state.propertiesModel,
                  }
              );
            });
          }
          return Container();
        }
    );
  }
}


