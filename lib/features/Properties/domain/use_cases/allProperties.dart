import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class GetAllProperties extends UseCase<List<PropertiesModel>,String>{
  final PropertiesRepository propertiesRepository;

  GetAllProperties(this.propertiesRepository);
  @override
  Future<Either<Failure, List<PropertiesModel>>> call(String token) async {
    return await propertiesRepository.getAllProperties(token);
  }

}