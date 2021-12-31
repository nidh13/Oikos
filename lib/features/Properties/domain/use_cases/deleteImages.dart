import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class DeleteImages extends UseCase<String,DeleteImagesParams>{
  final PropertiesRepository propertiesRepository;

  DeleteImages(this.propertiesRepository);
  @override
  Future<Either<Failure, String>> call(DeleteImagesParams deleteImagesParams) async {
    return await propertiesRepository.deleteImages(deleteImagesParams);
  }

}