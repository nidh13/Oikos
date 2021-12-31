import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Profile/domain/entities/userPicture_model.dart';
import 'package:oikosmobile/features/Profile/domain/repositories/profile_repository.dart';

class UpdatePassword extends UseCase<String,ResetPasswordParams>{
  final ProfileRepository profileRepository;

  UpdatePassword(this.profileRepository);
  @override
  Future<Either<Failure, String>> call(ResetPasswordParams params) async {
    return await profileRepository.updatePassword(params);
  }
}

