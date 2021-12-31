import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Offer/domain/repositories/offer_repository.dart';

class AcceptOffer extends UseCase<Offer,GetAllByPropertiesParams>{
  final OfferRepository offerRepository;

  AcceptOffer(this.offerRepository);
  @override
  Future<Either<Failure, Offer>> call(GetAllByPropertiesParams params) async {
    return await offerRepository.acceptOffer(params);
  }

}