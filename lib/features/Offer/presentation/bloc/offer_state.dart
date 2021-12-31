import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class OfferState extends Equatable {
  OfferState([List props = const <dynamic>[]]) : super();
}

class InitialOfferState extends OfferState {
  @override
  List<Object> get props => [];
}
class GoToOfferListState extends OfferState {
  final Offers offers;
  GoToOfferListState({@required this.offers});
  @override
  List<Object> get props => [offers];
}
class GoToOfferDisplayState extends OfferState {
  final Offer offer;
  final User buyer;
  GoToOfferDisplayState({@required this.offer,@required this.buyer});
  @override
  List<Object> get props => [offer,buyer];
}
class GoToSendMessageState extends OfferState {
  final User sender;
  GoToSendMessageState({@required this.sender});
  @override
  List<Object> get props => [sender];
}
class LoadingState extends OfferState {
  @override
  List<Object> get props => [];
}
