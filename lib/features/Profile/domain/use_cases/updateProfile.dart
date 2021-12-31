import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Profile/domain/repositories/profile_repository.dart';

class UpdateProfile extends UseCase<String,UpdateProfileParams>{
  final ProfileRepository profileRepository;

  UpdateProfile(this.profileRepository);
  @override
  Future<Either<Failure, String>> call(params) async {
    return await profileRepository.updateProfile(params);
  }

}