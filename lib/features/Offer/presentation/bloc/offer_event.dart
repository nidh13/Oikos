import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class OfferEvent extends Equatable {
  OfferEvent([List props = const <dynamic>[]]) : super();
}
class GoToFirstPageEvent extends OfferEvent {
  @override
  List<Object> get props => [];
}
class GoToOfferListEvent extends OfferEvent {
  final String token;
  final String id;

  GoToOfferListEvent({@required this.token,@required this.id});
  @override
  List<Object> get props => [token,id];
}
class GoToOfferDisplayEvent extends OfferEvent {
  final String token;
  final Offer offer;

  GoToOfferDisplayEvent({@required this.token,@required this.offer});
  @override
  List<Object> get props => [token,offer];
}
class GoToSendMessageEvent extends OfferEvent {
  final User sender;
  GoToSendMessageEvent({@required this.sender});
  @override
  List<Object> get props => [sender];
}
class AcceptOfferEvent extends OfferEvent {
  final String token;
  final String idOffer ;
  final String idProp ;
  AcceptOfferEvent({@required this.token,@required this.idOffer,@required this.idProp});
  @override
  List<Object> get props => [token,idOffer,idProp];
}
class RejectOfferEvent extends OfferEvent {
  final String token;
  final String idOffer ;
  final String idProp ;
  RejectOfferEvent({@required this.token,@required this.idOffer,@required this.idProp});
  @override
  List<Object> get props => [token,idOffer,idProp];
}
class CounterOfferEvent extends OfferEvent {
  final String token;
  final String idOffer ;
  final String idProp ;
  final String dateLimit ;
  final double price ;
  CounterOfferEvent({@required this.token,@required this.idOffer,@required this.dateLimit,@required this.price,@required this.idProp});
  @override
  List<Object> get props => [token,idOffer,idProp,dateLimit,price];
}

