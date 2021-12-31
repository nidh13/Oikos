import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class DeleteProperties extends UseCase<String,DeleteImPropertiesParams>{
  final PropertiesRepository propertiesRepository;

  DeleteProperties(this.propertiesRepository);
  @override
  Future<Either<Failure, String>> call(DeleteImPropertiesParams deleteImPropertiesParams) async {
    return await propertiesRepository.deleteProperties(deleteImPropertiesParams);
  }

}