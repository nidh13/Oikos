import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Calendar/domain/entities/disponibility_model.dart';
import 'package:oikosmobile/features/Calendar/domain/repositories/disponibility_repository.dart';

class AddMany extends UseCase<List<Disponibility>,AddManyDisponibilityParams>{
  final  DisponibilityRepository disponibilityRepository;

  AddMany(this.disponibilityRepository);
  @override
  Future<Either<Failure, List<Disponibility>>> call(AddManyDisponibilityParams addManyDisponibilityParams) async {
    return await disponibilityRepository.addMany(addManyDisponibilityParams);
  }
}