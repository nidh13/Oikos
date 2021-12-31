import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class GetPropertiesFiles extends UseCase<List<FileBien>,GetPropertiesFilesParams>{
  final PropertiesRepository propertiesRepository;

  GetPropertiesFiles(this.propertiesRepository);
  @override
  Future<Either<Failure, List<FileBien>>> call(GetPropertiesFilesParams getPropertiesFilesParams) async {
    return await propertiesRepository.getPropertiesFiles(getPropertiesFilesParams);
  }

}