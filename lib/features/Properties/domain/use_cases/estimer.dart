import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class Estimate extends UseCase<List<double>,EstimateParams>{
  final PropertiesRepository propertiesRepository;

  Estimate(this.propertiesRepository);
  @override
  Future<Either<Failure, List<double>>> call(EstimateParams estimateParams) async {
    return await propertiesRepository.estimate(estimateParams);
  }

}