import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class GetById extends UseCase<PropertiesModel,GetPropertiesByIdParams>{
  final PropertiesRepository propertiesRepository;

  GetById(this.propertiesRepository);

  @override
  Future<Either<Failure, PropertiesModel>> call(GetPropertiesByIdParams getPropertiesByIdParams) async {
    return await propertiesRepository.getById(getPropertiesByIdParams);
  }

}