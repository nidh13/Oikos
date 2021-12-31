import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/Utils/sharedPref.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/creat.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/deleteImages.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/deleteProperties.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/estimer.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/getById.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/getPropertiesTypes.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/myProperties.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/update.dart';
import 'package:oikosmobile/features/Properties/domain/use_cases/uploadPicture.dart';
import './bloc.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  final Create create;
  final Estimate estimate;
  final Update update;
  final UploadPicture uploadPicture;
  final GetById getById;
  final DeleteImages deleteImages;
  final DeleteProperties deleteProperties;
  final GetPropertiesTypes getPropertiesTypes;
  final MyProperties myProperties;

  PropertiesBloc({@required this.create,@required this.estimate,@required this.update,@required this.uploadPicture,@required this.getById,@required this.deleteImages,@required this.getPropertiesTypes,@required this.myProperties,@required this.deleteProperties}) : super(LoadingState());

  @override
  Stream<PropertiesState> mapEventToState(PropertiesEvent event,) async* {
    if (event is GoToFirstPageEvent) {
      final failureOrListProp = await myProperties(event.token);
      yield* failureOrListProp.fold(
              (failure) async* {
            print(failure);
          },
              (listProp) async* {
                yield FirstPageState(listProp: listProp);
          }
      );

    }
    if(event is GoTOAddPropertiesEvent){
      final listTypeofPropOrFailure = await getPropertiesTypes(event.token);
      yield* listTypeofPropOrFailure.fold(
          (failure) async* {
            print(_mapFailureToMessage(failure));
          },(list)async*{
        yield GoTOAddPropertiesState(listTypesOfProperties: list);
      }
      );

    }
    if (event is GoHomeDisplayEvent) {
      yield GoToGoHomeDisplayState(token: event.token,user: event.user);
    }

    if (event is CreatePropertiesEvent) {
      //yield LoadingState();
      final createPropertiesParams = CreatePropertiesParams(
          token: event.token, properties: event.propertiesModel);
      final failureOrToken = await create(createPropertiesParams);
      yield* failureOrToken.fold((failure) async* {
       /* yield ErrorAddPropertiesState(
          message: _mapFailureToMessage(failure),
        );*/
       print(_mapFailureToMessage(failure));

      }, (properties) async* {
        final failureOrListProp = await myProperties(event.token);
        yield* failureOrListProp.fold(
                (failure) async* {
                  print(failure);
            },
                (list) async* {
                  yield AddPropertiesLoadedState(propertiesModel: properties,listProp: list);
            }
        );
      });
    }
    if (event is EstimationPropertiesEvent) {
      yield LoadingState();
      final estimateParams = EstimateParams(token: event.token,id: event.propertiesModel.id);
      final failureOrEstimateList = await estimate(estimateParams);
      yield* failureOrEstimateList.fold(
          (failure) async*{
            print(_mapFailureToMessage(failure));
          },(list) async*{
        final failureOrListProp = await myProperties(event.token);
        yield* failureOrListProp.fold(
                (failure) async* {
              print(failure);
            },
                (listProp) async* {
                  yield EstimationPropertiesLoadedState(propertiesModel: event.propertiesModel,estimationList: list,listProp: listProp);
            }
        );
           //
      }
      );

    }
    if (event is ValidateEstimationEvent) {
      yield LoadingState();
      final createPropertiesParams = CreatePropertiesParams(
          token: event.token, properties: event.propertiesModel);
      final failureOrProperties = await update(createPropertiesParams);
      yield* failureOrProperties.fold((failure) async* {
        /* yield ErrorAddPropertiesState(
          message: _mapFailureToMessage(failure),
        );*/
        print(_mapFailureToMessage(failure));

      }, (propertiesModel) async* {
        final failureOrListProp = await myProperties(event.token);
        yield* failureOrListProp.fold(
                (failure) async* {
              print(failure);
            },
                (listProp) async* {
                  yield ValidateEstimationState(propertiesModel: propertiesModel,listProp: listProp);
                }
        );
       // yield ValidateEstimationState(propertiesModel: propertiesModel);
      });
      //yield ValidateEstimationState();
    }
    if (event is GoTOGalleryEvent) {
      yield GalleryState(propertiesModel: event.propertiesModel,fromProp: event.fromProp);
    }
    if (event is GoTOImageDisplayEvent) {
      yield ImageDisplayState(image: event.image,propertiesModel: event.propertiesModel,fromProp: event.fromProp);
    }
    // hedha
    if (event is GoToPropertiesImagesDisplayEvent) {
      final uploadPropImageParams = UploadPropImageParams(image: event.image,token: event.token,id: event.propertiesModel.id);
      final successOrFailure = await uploadPicture(uploadPropImageParams);
      yield* successOrFailure.fold(
          (failure)async*{
            print(_mapFailureToMessage(failure));
          },
          (string)async*{
            final getPropertiesByIdParams = GetPropertiesByIdParams(token: event.token,id: event.propertiesModel.id);
            final propertiesOrFailure = await getById(getPropertiesByIdParams);
            yield* propertiesOrFailure.fold(
                (failure)async*{
                  print(_mapFailureToMessage(failure));
                },
                (properties)async*{
                  yield PropertiesImagesDisplayState(propertiesModel: properties,fromProp: event.fromProp);
                }
            );
          }
      );

    }
    if (event is GoToDeleteImagesDisplayEvent) {
      yield DeleteImagesState(propertiesModel: event.propertiesModel,fromProp: event.fromProp);
    }
    if (event is GoTOImageUpdateDisplayEvent) {
      yield PropertiesImagesDisplayState(propertiesModel: event.propertiesModel,fromProp: true);
    }
    if (event is GoToImagesSavedDisplayEvent) {
      final failureOrListProp = await myProperties(event.token);
      yield* failureOrListProp.fold(
              (failure) async* {
            print(failure);
          },
              (listProp) async* {
            yield  ImagesSavedState(propertiesModel:event.propertiesModel,listProp: listProp);
          }
      );
     // yield ImagesSavedState(propertiesModel:event.propertiesModel);
    }
    if (event is GoToAdTextDisplayEvent) {
      yield AdTextState(propertiesModel: event.propertiesModel);
    }
    if (event is GoTOUpdatePropertiesDisplayEvent) {
      yield GoToUpdatePropertiesState(propertiesModel: event.propertiesModel);
    }
    if (event is AddDescriptionEvent) {
      final createPropertiesParams = CreatePropertiesParams(
          token: event.token, properties: event.propertiesModel);
      final failureOrProperties = await update(createPropertiesParams);
      yield* failureOrProperties.fold((failure) async* {
        /* yield ErrorAddPropertiesState(
          message: _mapFailureToMessage(failure),
        );*/
        print(_mapFailureToMessage(failure));

      }, (propertiesModel) async* {
        final failureOrListProp = await myProperties(event.token);
        yield* failureOrListProp.fold(
                (failure) async* {
              print(failure);
            },
                (listProp) async* {
                  yield PropertieDisplayState(propertiesModel: propertiesModel,listProp:listProp);
            }
        );

      });
      //
    }
    if(event is GoToCameraEvent){
      yield CameraState(propertiesModel: event.propertiesModel,fromProp: event.fromProp);
    }
    if(event is CreateCalendarEvent){
      yield CreateCalendarState(propertiesModel: event.propertiesModel,listProp: event.listProp);
    }
    if(event is GoToFilterImageEvent){
      yield FilterImageState(image: event.image,propertiesModel: event.propertiesModel,fromProp: event.fromProp);
    }
    if (event is DeleteImagesEvent) {
      final deleteImagesParams = DeleteImagesParams(token: event.token,imageId: event.listId);
      final successOrFailure = await deleteImages(deleteImagesParams);
      yield* successOrFailure.fold(
              (failure)async*{
            print(_mapFailureToMessage(failure));
          },
              (string)async*{
                print("deleted");
            final getPropertiesByIdParams = GetPropertiesByIdParams(token: event.token,id: event.propertiesModel.id);
            final propertiesOrFailure = await getById(getPropertiesByIdParams);
            yield* propertiesOrFailure.fold(
                    (failure)async*{
                  print(_mapFailureToMessage(failure));
                },
                    (properties)async*{
                  yield PropertiesImagesDisplayState(propertiesModel: properties,fromProp: event.fromProp);
                }
            );
          }
      );

      // yield PropertiesImagesDisplayState();
    }
    if(event is GoToPropertieDisplay){
      yield  LoadingState();
      final getPropertiesByIdParams = GetPropertiesByIdParams(token: event.token,id: event.propertiesModel.id);
      final propertiesOrFailure = await getById(getPropertiesByIdParams);
      yield* propertiesOrFailure.fold(
              (failure)async*{
            print(_mapFailureToMessage(failure));
          },
              (propertie)async*{
                final failureOrListProp = await myProperties(event.token);
                yield* failureOrListProp.fold(
                        (failure) async* {
                      print(failure);
                    },
                        (listProp) async* {
                          SharedPref sharedPref =SharedPref();
                          bool contain = await sharedPref.contain("calendar");
                          if(contain){
                            var  varShared = await sharedPref.read("calendar");
                            FullCalendar c = FullCalendar.fromJson(await sharedPref.read("calendar"));
                            yield PropertieDisplayState(propertiesModel: propertie,listProp:listProp,calendar: c);
                          }else{
                            yield PropertieDisplayState(propertiesModel: propertie,listProp: listProp);
                          }
                    }
                );
          }
      );

    }
    if(event is GoToListOffersEvent){
      yield GoToListOffersState(listProp: event.listProp,propertiesModel: event.propertiesModel);
    }
    if(event is DeletePropertiesEvent){
      yield LoadingState();
      final deleteParams = DeleteImPropertiesParams(token: event.token,id: event.id);
      final failureOrDelete = await deleteProperties(deleteParams);
      yield* failureOrDelete.fold(
              (failure) async*{
            print(_mapFailureToMessage(failure));
          },(list) async*{
        final failureOrListProp = await myProperties(event.token);
        yield* failureOrListProp.fold(
                (failure) async* {
              print(failure);
            },
                (listProp) async* {
              yield FirstPageState(listProp: listProp);
            }
        );
        //
      }
      );
    }
    if (event is UpdatePropertiesEvent) {
      final createPropertiesParams = CreatePropertiesParams(
          token: event.token, properties: event.propertiesModel);
      final failureOrProperties = await update(createPropertiesParams);
      yield* failureOrProperties.fold((failure) async* {
        /* yield ErrorAddPropertiesState(
          message: _mapFailureToMessage(failure),
        );*/
        print(_mapFailureToMessage(failure));

      }, (propertiesModel) async* {
        final failureOrListProp = await myProperties(event.token);
        yield* failureOrListProp.fold(
                (failure) async* {
              print(failure);
            },
                (listProp) async* {
                  yield FirstPageState(listProp: listProp);
            }
        );

      });
    }

  }

  @override
  void onTransition(Transition<PropertiesEvent, PropertiesState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    if (failure is ServerFailure) {
      return failure.message;
    } else {
      return 'Unexpected Failure';
  }
}
}
