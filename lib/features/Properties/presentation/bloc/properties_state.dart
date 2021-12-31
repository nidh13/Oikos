import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/entities/typesOfProperties_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class PropertiesState extends Equatable {
  PropertiesState([List props = const <dynamic>[]]) : super();
}

class InitialPropertiesState extends PropertiesState {
  @override
  List<Object> get props =>  [];
}
class FirstPageState extends PropertiesState {
  final List<PropertiesModel>listProp;

  FirstPageState({@required this.listProp});
  @override
  List<Object> get props => [listProp];
}
class LoadingState extends PropertiesState {
  @override
  List<Object> get props => [];
}

class AddPropertiesLoadedState extends PropertiesState {
  final PropertiesModel propertiesModel ;
  final List<PropertiesModel>listProp;

  AddPropertiesLoadedState({@required this.propertiesModel,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,listProp];
}
class ErrorAddPropertiesState extends PropertiesState {
  final String message;
  ErrorAddPropertiesState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

class EstimationPropertiesLoadedState extends PropertiesState {
  final PropertiesModel propertiesModel;
  final List<double> estimationList;
  final List<PropertiesModel>listProp;

  EstimationPropertiesLoadedState({@required this.propertiesModel,@required this.estimationList,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,estimationList,listProp];
}
class EstimationPropertiestState extends PropertiesState {
  final String message;
  EstimationPropertiestState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
class ValidateEstimationState extends PropertiesState {
  final List<PropertiesModel>listProp;
  final PropertiesModel propertiesModel;

  ValidateEstimationState({@required this.propertiesModel,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,listProp];
}


class GoToEstimationResultState extends PropertiesState{
  @override
  List<Object> get props => [];
}
class GoTOAddPropertiesState extends PropertiesState {
 final List<TypesOfProperties> listTypesOfProperties;

  GoTOAddPropertiesState({@required this.listTypesOfProperties});
  @override
  List<Object> get props => [listTypesOfProperties];
}
class GoToGoHomeDisplayState extends PropertiesState {
  final String token;
  final User user;

  GoToGoHomeDisplayState({@required this.token,@required this.user});

  @override
  List<Object> get props =>  [token,user];
}
class GalleryState extends PropertiesState {
  final PropertiesModel propertiesModel ;
  final bool fromProp ;
  GalleryState({@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [propertiesModel,fromProp];
}
class CameraState extends PropertiesState {
  final PropertiesModel propertiesModel ;
  final bool fromProp;
  CameraState({@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [propertiesModel,fromProp];
}
class FilterImageState extends PropertiesState {
  final File image;
  final PropertiesModel propertiesModel ;
  final bool fromProp;
  FilterImageState({@required this.image,@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [image,propertiesModel,fromProp];
}
class PropertiesImagesDisplayState extends PropertiesState {
  final bool fromProp;
  final PropertiesModel propertiesModel ;
  PropertiesImagesDisplayState({@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [fromProp,propertiesModel];
}
class ImageDisplayState extends PropertiesState {
  final File image;
  final PropertiesModel propertiesModel;
  final bool fromProp;
  ImageDisplayState({@required this.image,@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [image,propertiesModel,fromProp];
}
class DeleteImagesState extends PropertiesState {
 final PropertiesModel propertiesModel ;
 final bool fromProp ;
  DeleteImagesState({@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [propertiesModel,fromProp];
}
class ImagesSavedState extends PropertiesState {
  final PropertiesModel propertiesModel ;
  final List<PropertiesModel>listProp;
  ImagesSavedState({@required this.propertiesModel,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,listProp];
}
class CreateCalendarState extends PropertiesState {
  final PropertiesModel propertiesModel ;
  final List<PropertiesModel>listProp;
  CreateCalendarState({@required this.propertiesModel,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,listProp];
}
class AdTextState extends PropertiesState {
  final PropertiesModel propertiesModel ;

  AdTextState({@required this.propertiesModel});
  @override
  List<Object> get props => [propertiesModel];
}
class PropertieDisplayState extends PropertiesState {
 final PropertiesModel propertiesModel;
 final List<PropertiesModel>listProp;
 final FullCalendar calendar;
  PropertieDisplayState({@required this.propertiesModel,@required this.listProp,@required this.calendar});
  @override
  List<Object> get props => [propertiesModel,listProp,calendar];
}
class GoToListOffersState extends PropertiesState {
  final PropertiesModel propertiesModel;
  final List<PropertiesModel>listProp;

  GoToListOffersState({@required this.propertiesModel,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,listProp];
}
class GoToUpdatePropertiesState extends PropertiesState {
  final PropertiesModel propertiesModel;
  GoToUpdatePropertiesState({@required this.propertiesModel});
  @override
  List<Object> get props => [propertiesModel];
}
