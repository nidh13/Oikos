import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Service/domain/entities/order.dart';

abstract class ServiceRepository {
  Future<Either<Failure,Orders>> getServices(String token);
  Future<Either<Failure,String>> payServices(PayParams params);
}