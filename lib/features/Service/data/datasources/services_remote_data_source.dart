import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Service/domain/entities/order.dart';

abstract class ServiceRemoteDataSource{
  Future<Orders> getServices (String token);
  Future<String> payServices (PayParams params);

}