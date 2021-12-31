import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Calendar/domain/entities/disponibility_model.dart';

abstract class DisponibilityRepository{
  Future<Either<Failure,List<Disponibility>>> addMany(AddManyDisponibilityParams addManyDisponibilityParams);
 // Future<Either<Failure,List<Disponibility>>> myDisponibility(String token);

}