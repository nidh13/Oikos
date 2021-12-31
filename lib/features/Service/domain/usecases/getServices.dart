import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Service/domain/entities/order.dart';
import 'package:oikosmobile/features/Service/domain/repositories/service_repository.dart';

class GetServices extends UseCase<Orders,String>{
  final ServiceRepository serviceRepository;
  GetServices(this.serviceRepository);
  @override
  Future<Either<Failure, Orders>> call(String token) async {
    return await serviceRepository.getServices(token);
  }

}