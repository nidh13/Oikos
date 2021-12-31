import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';

abstract class OfferRepository{
  Future<Either<Failure,Offers>> getAllByProperties(GetAllByPropertiesParams getAllByProperties);
  Future<Either<Failure,Offer>> acceptOffer(GetAllByPropertiesParams getAllByProperties);
  Future<Either<Failure,Offer>> rejectOffer(GetAllByPropertiesParams getAllByProperties);
  Future<Either<Failure,Offer>> counterOffer(CounterOfferParams counterOfferParams);
}