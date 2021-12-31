import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class GetMyPropertiesWithStatus extends UseCase<List<PropertiesModel>,GetMyPropertiesWithStatusParams>{
  final PropertiesRepository propertiesRepository;

  GetMyPropertiesWithStatus(this.propertiesRepository);
  @override
  Future<Either<Failure, List<PropertiesModel>>> call(GetMyPropertiesWithStatusParams getMyPropertiesWithStatusParams) async {
    return await propertiesRepository.getMyPropertiesWithStatus(getMyPropertiesWithStatusParams);
  }

}