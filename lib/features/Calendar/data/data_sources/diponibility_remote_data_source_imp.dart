import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Calendar/domain/entities/disponibility_model.dart';

abstract class DisponibilityRemoteDataSource{
  Future<List<Disponibility>> addMany (AddManyDisponibilityParams addManyDisponibilityParams);
}