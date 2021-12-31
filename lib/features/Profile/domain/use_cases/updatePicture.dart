import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Profile/domain/entities/userPicture_model.dart';
import 'package:oikosmobile/features/Profile/domain/repositories/profile_repository.dart';

class UpdatePicture extends UseCase<UserPicture,UpdateImageParams>{
  final ProfileRepository profileRepository;
  UpdatePicture(this.profileRepository);
  @override
  Future<Either<Failure, UserPicture>> call(UpdateImageParams params) async {
    return await profileRepository.updatePicture(params);
  }

}