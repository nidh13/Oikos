import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Offer/domain/repositories/offer_repository.dart';

class GetOffersByProperties extends UseCase<Offers,GetAllByPropertiesParams>{
  final OfferRepository offerRepository;

  GetOffersByProperties(this.offerRepository);

  @override
  Future<Either<Failure, Offers>> call(GetAllByPropertiesParams params) async {
    return await offerRepository.getAllByProperties(params);
  }


}