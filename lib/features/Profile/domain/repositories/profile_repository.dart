import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Profile/domain/entities/userPicture_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure,UserPicture>> updatePicture(UpdateImageParams updateImageParams);
  Future<Either<Failure,String>> updateProfile(UpdateProfileParams registerParams);
  Future<Either<Failure,String>> updatePassword(ResetPasswordParams resetPasswordParams);
  Future<Either<Failure,String>> updateGeneralInformation(UpdateGeneralInformationParams updateGeneralInformationParams);
}