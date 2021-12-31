import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class GetAllPropertiesWithStatus extends UseCase<List<PropertiesModel>,GetAllPropertiesWithStatusParams>{
  final PropertiesRepository propertiesRepository;

  GetAllPropertiesWithStatus(this.propertiesRepository);
  @override
  Future<Either<Failure, List<PropertiesModel>>> call(GetAllPropertiesWithStatusParams getAllPropertiesWithStatusParams) async {
    return await propertiesRepository.getAllPropertiesWithStatus(getAllPropertiesWithStatusParams);
  }

}