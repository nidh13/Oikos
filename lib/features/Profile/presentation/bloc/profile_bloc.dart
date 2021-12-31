import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updateGeneralInformation.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updatePassword.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updatePicture.dart';
import 'package:oikosmobile/features/Profile/domain/use_cases/updateProfile.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getDepartments.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getProfile.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdatePicture updatePicture ;
  final GetDepartments getDepartments;
  final UpdateProfile updateProfile ;
  final UpdatePassword updatePassword;
  final UpdateGeneralInformation updateGeneralInformation;
  final GetProfile getProfile;

  ProfileBloc({@required this.updatePicture,@required this.getDepartments,@required this.updateProfile,@required this.updatePassword,@required this.updateGeneralInformation,@required this.getProfile}) : super(InitialProfileState());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is GoToFirstPageEvent) {
      yield FirstPageState();
    }
    if (event is GoToUpdateProfileEvent) {
      final failureOrDepartments = await getDepartments(NoParams());
      print(failureOrDepartments);
      yield* failureOrDepartments.fold((failure) async* {
        print(failure);
      }, (list) async* {
        yield GoToUpdateProfileState(departments: list);

      });

    }
    if(event is GoToImageDisplayEvent){
      yield ImageDisplayState(image: event.image,firstConexion: event.firstConexion);
    }
    if(event is GoToImagePickerEvent){
      yield PickImageState(firstConexion: event.firstConexion);
    }
    if(event is CropEvent){
      final createPropertiesParams = UpdateImageParams(image: event.image, token: event.token);
      final failureOrPicture = await updatePicture(createPropertiesParams);
     yield* failureOrPicture.fold(
         (failure)async*{
           print("failure");
         },(image)async*{
           yield CroppedState(firstConexion: event.firstConexion);
     }
     );
    }
    if(event is UpdateProfileEvent){
      yield LoadingState();
      final updateProfileParams = UpdateProfileParams(
        token: event.token,
        firstName: event.firstName,
        lastName: event.lastName,
        password: event.password,
        phoneNumber: event.phoneNumber,
        email: event.email
      );
      final failureOrString = await updateProfile(updateProfileParams);
      yield* failureOrString.fold(
          (failure) async*{
           String message= _mapFailureToMessage(failure);
            print(message);
          },
          (string)async*{
            yield LogoutState();
          }
      );
    }
    if(event is UpdateGeneralInformationEvent){
      yield LoadingState();
      final updateGeneralInformationParams = UpdateGeneralInformationParams(
          token: event.token,
        generalInformationModel: event.generalInformationModel
      );
      final failureOrString = await updateGeneralInformation(updateGeneralInformationParams);
      yield* failureOrString.fold(
              (failure) async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
              (string)async*{
                final failureOrUser = await getProfile(event.token);
                yield* failureOrUser.fold(
                    (failure)async*{
                      print(failure);
                    },
                    (user)async*{
                      yield ProfileUpdatedState(user: user);
                    }
                );
          }
      );
    }
  }
  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    if(failure is ServerFailure){
      return failure.message;
    }else{
      return 'Unexpected Failure';
    }
  }
}
