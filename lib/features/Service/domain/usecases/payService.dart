import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Service/domain/repositories/service_repository.dart';

class PayService extends UseCase<String,PayParams>{
  final ServiceRepository serviceRepository;
  PayService(this.serviceRepository);
  @override
  Future<Either<Failure, String>> call(PayParams params) async {
    return await serviceRepository.payServices(params);
  }
}