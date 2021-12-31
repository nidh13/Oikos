import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Properties/data/data_sources/properties_remote_data_source.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/entities/typesOfProperties_model.dart';
import 'package:oikosmobile/features/Properties/domain/repositories/properties_repository.dart';

class PropertiesRepositoryImpl implements PropertiesRepository{
  final PropertiesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  PropertiesRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo});
  @override
  Future<Either<Failure, PropertiesModel>> create(CreatePropertiesParams createPropertiesParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.create(createPropertiesParams);
      if (response is PropertiesModel) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, PropertiesModel>> getById(GetPropertiesByIdParams getPropertiesByIdParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getById(getPropertiesByIdParams);
      if (response is PropertiesModel) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, List<PropertiesModel>>> myProperties(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.myProperties(token);
      if (response is List<PropertiesModel>) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, List<TypesOfProperties>>> getPropertiesTypes(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getPropertiesTypes(token);
      if (response is List<TypesOfProperties>) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, PropertiesModel>> update(CreatePropertiesParams createPropertiesParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.update(createPropertiesParams);
      if (response is PropertiesModel) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, List<FileBien>>> getPropertiesFiles(GetPropertiesFilesParams getPropertiesFilesParams) {
    // TODO: implement getPropertiesFiles
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadPicture(UploadPropImageParams uploadPropImageParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.uploadPicture(uploadPropImageParams);
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
  Future<Either<Failure, List<PropertiesModel>>> allProperties(String token) {
    // TODO: implement allProperties
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<double>>> estimate(EstimateParams estimateParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.estimate(estimateParams);
      if (response is List<double>) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteImages(DeleteImagesParams deleteImagesParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.deleteImages(deleteImagesParams);
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
  Future<Either<Failure, List<PropertiesModel>>> getAllProperties(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getAllProperties(token);
      if (response is List<PropertiesModel>) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, List<PropertiesModel>>> getAllPropertiesWithStatus(GetAllPropertiesWithStatusParams getAllPropertiesWithStatusParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getAllPropertiesWithStatus(getAllPropertiesWithStatusParams);
      if (response is List<PropertiesModel>) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, List<PropertiesModel>>> getMyPropertiesWithStatus(GetMyPropertiesWithStatusParams getMyPropertiesWithStatusParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getMyPropertiesWithStatus(getMyPropertiesWithStatusParams);
      if (response is List<PropertiesModel>) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProperties(DeleteImPropertiesParams deleteImPropertiesParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.deleteProperties(deleteImPropertiesParams);
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