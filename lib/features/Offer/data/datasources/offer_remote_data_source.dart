import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';

abstract class OfferRemoteDataSource{
  Future<Offers> getAllByProperties(GetAllByPropertiesParams getAllByProperties);
  Future<Offer> acceptOffer(GetAllByPropertiesParams getAllByProperties);
  Future<Offer> rejectOffer(GetAllByPropertiesParams getAllByProperties);
  Future<Offer> counterOffer(CounterOfferParams counterOfferParams);
}