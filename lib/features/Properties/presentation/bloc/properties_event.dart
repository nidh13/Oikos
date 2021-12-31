import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class PropertiesEvent extends Equatable {
  PropertiesEvent([List props = const <dynamic>[]]) : super();
}

class GoToFirstPageEvent extends PropertiesEvent {
  final String token;

  GoToFirstPageEvent({@required this.token});
  @override
  List<Object> get props => [token];
}
class GoTOAddPropertiesEvent extends PropertiesEvent {
  final String token;
  GoTOAddPropertiesEvent({@required this.token});
  @override
  List<Object> get props => [token];
}
class GoHomeDisplayEvent extends PropertiesEvent {
  final String token;
  final User user;

  GoHomeDisplayEvent({@required this.token,@required this.user});

  @override
  List<Object> get props => [token,user];
}
class GoToPropertieDisplay extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final List<PropertiesModel>listProp;
  final String token;

  GoToPropertieDisplay({@required this.propertiesModel,@required this.listProp,@required this.token});
  @override
  List<Object> get props => [propertiesModel,listProp,token];
}

class CreatePropertiesEvent extends PropertiesEvent {
 final PropertiesModel propertiesModel;
 final String token;
  CreatePropertiesEvent({@required this.propertiesModel,@required this.token}):super([propertiesModel,token]);
  @override
  List<Object> get props => [propertiesModel,token];

}
class EstimationPropertiesEvent extends PropertiesEvent {
  final String token ;
  final PropertiesModel propertiesModel;

  EstimationPropertiesEvent({@required this.propertiesModel,@required this.token});
  @override
  List<Object> get props => [propertiesModel,token];
}
class ValidateEstimationEvent extends PropertiesEvent {
  final String token ;
  final PropertiesModel propertiesModel;

  ValidateEstimationEvent({@required this.token,@required this.propertiesModel});
  @override
  List<Object> get props => [token,propertiesModel];
}
class GoTOGalleryEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final bool fromProp ;

  GoTOGalleryEvent({@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [propertiesModel,fromProp];
}
class GoToCameraEvent extends PropertiesEvent {
 final PropertiesModel propertiesModel;
 final bool fromProp;
  GoToCameraEvent({@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [propertiesModel,fromProp];
}
class GoToFilterImageEvent extends PropertiesEvent {
  final File image;
  final PropertiesModel propertiesModel;
  final bool fromProp;
  GoToFilterImageEvent({@required this.image,@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [image,propertiesModel,fromProp];
}
class GoToPropertiesImagesDisplayEvent extends PropertiesEvent {
  final String token;
 final File image;
 final PropertiesModel propertiesModel;
  final bool fromProp;
  GoToPropertiesImagesDisplayEvent({@required this.image,@required this.propertiesModel,@required this.token,@required this.fromProp});
  @override
  List<Object> get props => [image,propertiesModel,token,fromProp];
}
class GoTOImageDisplayEvent extends PropertiesEvent {
  final File image;
  final PropertiesModel propertiesModel;
  final bool fromProp;
  GoTOImageDisplayEvent({@required this.image,@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [image,propertiesModel,fromProp];
}
class GoToDeleteImagesDisplayEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final bool fromProp ;
  GoToDeleteImagesDisplayEvent({@required this.propertiesModel,@required this.fromProp});
  @override
  List<Object> get props => [propertiesModel,fromProp];
}
class GoToImagesSavedDisplayEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final String token;
  GoToImagesSavedDisplayEvent({@required this.propertiesModel,@required this.token});
  @override
  List<Object> get props => [propertiesModel,token];
}
class GoToAdTextDisplayEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;

  GoToAdTextDisplayEvent({@required this.propertiesModel});
  @override
  List<Object> get props => [propertiesModel];
}
class AddDescriptionEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final String token;

  AddDescriptionEvent({@required this.propertiesModel,@required this.token});
  @override
  List<Object> get props => [propertiesModel,token];
}
class CreateCalendarEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final List<PropertiesModel> listProp;

  CreateCalendarEvent({@required this.propertiesModel,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,listProp];
}
class DeleteImagesEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final List <String> listId;
  final String token;
  final bool fromProp ;
  DeleteImagesEvent({@required this.propertiesModel,@required this.listId,@required this.token,@required this.fromProp});
  @override
  List<Object> get props => [propertiesModel,listId,token,fromProp];
}
class GoToListOffersEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final List<PropertiesModel>listProp;
  GoToListOffersEvent({@required this.propertiesModel,@required this.listProp});
  @override
  List<Object> get props => [propertiesModel,listProp];
}
class DeletePropertiesEvent extends PropertiesEvent {
  final String id;
  final String token;

  DeletePropertiesEvent({@required this.id,@required this.token});
  @override
  List<Object> get props => [id,token];
}
class GoTOImageUpdateDisplayEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  GoTOImageUpdateDisplayEvent({@required this.propertiesModel});
  @override
  List<Object> get props => [propertiesModel];
}
class GoTOUpdatePropertiesDisplayEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  GoTOUpdatePropertiesDisplayEvent({@required this.propertiesModel});
  @override
  List<Object> get props => [propertiesModel];
}
class UpdatePropertiesEvent extends PropertiesEvent {
  final PropertiesModel propertiesModel;
  final String token;
  UpdatePropertiesEvent({@required this.propertiesModel,@required this.token}):super([propertiesModel,token]);
  @override
  List<Object> get props => [propertiesModel,token];

}


