import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Offer/domain/repositories/offer_repository.dart';

class RejectOffer extends UseCase<Offer,GetAllByPropertiesParams>{
  final OfferRepository offerRepository;

  RejectOffer(this.offerRepository);
  @override
  Future<Either<Failure, Offer>> call(GetAllByPropertiesParams params) async {
    return await offerRepository.rejectOffer(params);
  }

}