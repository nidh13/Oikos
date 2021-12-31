import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Calendar/data/data_sources/diponibility_remote_data_source_imp.dart';
import 'package:oikosmobile/features/Calendar/domain/entities/disponibility_model.dart';
import 'package:oikosmobile/features/Calendar/domain/repositories/disponibility_repository.dart';

class DisponibilityRepositoryImpl implements DisponibilityRepository{
  final DisponibilityRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  DisponibilityRepositoryImpl({@required this.remoteDataSource,@required  this.networkInfo});

  @override
  Future<Either<Failure, List<Disponibility>>> addMany(AddManyDisponibilityParams addManyDisponibilityParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.addMany(addManyDisponibilityParams);
      if (response is List<Disponibility>) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

}