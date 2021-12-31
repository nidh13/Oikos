import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/typesOfProperties_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class UploadPicture extends UseCase<String,UploadPropImageParams>{
  final PropertiesRepository propertiesRepository;

  UploadPicture(this.propertiesRepository);
  @override
  Future<Either<Failure, String>> call(UploadPropImageParams uploadPropImageParams) async {
    return await propertiesRepository.uploadPicture(uploadPropImageParams);
  }

}