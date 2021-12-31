import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Profile/domain/entities/userPicture_model.dart';

abstract class ProfileRemoteDataSource{
  Future<UserPicture> updatePicture (UpdateImageParams updateImageParams);
  Future<String> updateProfile (UpdateProfileParams registerParams);
  Future<String> updatePassword (ResetPasswordParams resetPasswordParams);
  Future<String> updateGeneralInformation (UpdateGeneralInformationParams updateGeneralInformationParams);
}