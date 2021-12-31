import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Notification/data/data_sources/notifications_remote_data_source.dart';
import 'package:oikosmobile/features/Notification/domain/entities/notifications_model.dart';
import 'package:oikosmobile/features/Notification/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository{
  final NotificationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  NotificationsRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo});
  @override
  Future<Either<Failure, Notifications>> getAll(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getAll(token);
      if (response is Notifications) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, Notifications>> getUnRead(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getUnRead(token);
      if (response is Notifications) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> read(GetNotificationByIdParams getNotificationByIdParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.read(getNotificationByIdParams);
      if (response is String) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, OneNotification>> getById(GetNotificationByIdParams getNotificationByIdParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getById(getNotificationByIdParams);
      if (response is OneNotification) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

}