import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Service/data/datasources/services_remote_data_source.dart';
import 'package:oikosmobile/features/Service/domain/entities/order.dart';
import 'package:oikosmobile/features/Service/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository{
  final ServiceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  ServiceRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo});

  @override
  Future<Either<Failure, Orders>> getServices(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getServices(token);
      if (response is Orders) {
        print("ok ok ok");
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> payServices(PayParams params) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.payServices(params);
      if (response is String) {
        print("ok ok ok");
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }


}