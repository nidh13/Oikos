import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Profile/data/data_sources/profile_remote_data_source.dart';
import 'package:oikosmobile/features/Profile/domain/entities/userPicture_model.dart';
import 'package:oikosmobile/features/Profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  ProfileRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo});
  @override
  Future<Either<Failure, UserPicture>> updatePicture(UpdateImageParams updateImageParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.updatePicture(updateImageParams);
      if (response is UserPicture) {
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
  Future<Either<Failure, String>> updatePassword(ResetPasswordParams resetPasswordParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.updatePassword(resetPasswordParams);
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
  Future<Either<Failure, String>> updateProfile(UpdateProfileParams updateProfileParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.updateProfile(updateProfileParams);
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
  Future<Either<Failure, String>> updateGeneralInformation(UpdateGeneralInformationParams updateGeneralInformationParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.updateGeneralInformation(updateGeneralInformationParams);
      if (response is String) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

}