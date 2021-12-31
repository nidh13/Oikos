
import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Profile/domain/repositories/profile_repository.dart';

class UpdateGeneralInformation extends UseCase<String,UpdateGeneralInformationParams>{
  final ProfileRepository profileRepository;

  UpdateGeneralInformation(this.profileRepository);

  @override
  Future<Either<Failure, String>> call(UpdateGeneralInformationParams params) async {
    return await profileRepository.updateGeneralInformation(params);
  }


}