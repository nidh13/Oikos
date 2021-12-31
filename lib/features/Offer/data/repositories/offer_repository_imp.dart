import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Offer/data/datasources/offer_remote_data_source.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Offer/domain/repositories/offer_repository.dart';

class OfferRepositoryImpl implements OfferRepository{
  final OfferRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  OfferRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo});
  @override
  Future<Either<Failure, Offer>> acceptOffer(GetAllByPropertiesParams getAllByProperties) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.acceptOffer(getAllByProperties);
      if (response is Offer) {
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
  Future<Either<Failure, Offer>> counterOffer(CounterOfferParams counterOfferParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.counterOffer(counterOfferParams);
      if (response is Offer) {
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
  Future<Either<Failure, Offers>> getAllByProperties(GetAllByPropertiesParams getAllByProperties) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getAllByProperties(getAllByProperties);
      if (response is Offers) {
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
  Future<Either<Failure, Offer>> rejectOffer(GetAllByPropertiesParams getAllByProperties) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.rejectOffer(getAllByProperties);
      if (response is Offer) {
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