
import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/typesOfProperties_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class GetPropertiesTypes extends UseCase<List<TypesOfProperties>,String>{
  final PropertiesRepository propertiesRepository;

  GetPropertiesTypes(this.propertiesRepository);
  @override
  Future<Either<Failure, List<TypesOfProperties>>> call(String token) async {
    return await propertiesRepository.getPropertiesTypes(token);
  }

}