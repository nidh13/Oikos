import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/acceptOffer.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/counterOffer.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/getOffersByProperties.dart';
import 'package:oikosmobile/features/Offer/domain/usecases/rejectOffer.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getUserById.dart';
import './bloc.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final AcceptOffer acceptOffer;
  final CounterOffer counterOffer;
  final RejectOffer rejectOffer;
  final GetOffersByProperties getOffersByProperties;
  final GetUserById getUserById;

  OfferBloc({@required this.acceptOffer,@required this.counterOffer,@required this.rejectOffer,@required this.getOffersByProperties,@required this.getUserById}) : super(InitialOfferState());


  @override
  Stream<OfferState> mapEventToState(
    OfferEvent event,
  ) async* {
    if(event is GoToOfferListEvent){
      yield LoadingState();
      GetAllByPropertiesParams getAllByPropertiesParams = GetAllByPropertiesParams(
        token: event.token,
        id: event.id,
      );
      final failureOrOffers = await getOffersByProperties(getAllByPropertiesParams);
      yield* failureOrOffers.fold(
          (failure)async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
          (offers)async*{

            yield GoToOfferListState(offers: offers);
          }
      );
    }
    if(event is GoToOfferDisplayEvent){
      yield LoadingState();
      GetUserByIdParams getUserByIdParams =GetUserByIdParams(token: event.token,id: event.offer.senderID);
      final failureOrUser= await getUserById(getUserByIdParams);
      yield* failureOrUser.fold(
          (failure)async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
          (user)async*{
            yield GoToOfferDisplayState(offer: event.offer, buyer: user);
          }
      );
    }
    if(event is AcceptOfferEvent){
      yield LoadingState();
      GetAllByPropertiesParams getAllByPropertiesParams = GetAllByPropertiesParams(
        token: event.token,
        id: event.idOffer,
      );
      final failureOrOffers = await acceptOffer(getAllByPropertiesParams);
      yield* failureOrOffers.fold(
              (failure)async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
              (offers)async*{
                GetAllByPropertiesParams getAllByPropertiesParams = GetAllByPropertiesParams(
                  token: event.token,
                  id: event.idProp,
                );
                final failureOrOffers = await getOffersByProperties(getAllByPropertiesParams);
                yield* failureOrOffers.fold(
                        (failure)async*{
                      String message= _mapFailureToMessage(failure);
                      print(message);
                    },
                        (offers)async*{
                      yield GoToOfferListState(offers: offers);
                    }
                );
          }
      );

    }
    if(event is RejectOfferEvent){
      yield LoadingState();
      GetAllByPropertiesParams getAllByPropertiesParams = GetAllByPropertiesParams(
        token: event.token,
        id: event.idOffer,
      );
      final failureOrOffers = await rejectOffer(getAllByPropertiesParams);
      yield* failureOrOffers.fold(
              (failure)async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
              (offers)async*{
                GetAllByPropertiesParams getAllByPropertiesParams = GetAllByPropertiesParams(
                  token: event.token,
                  id: event.idProp,
                );
                final failureOrOffers = await getOffersByProperties(getAllByPropertiesParams);
                yield* failureOrOffers.fold(
                        (failure)async*{
                      String message= _mapFailureToMessage(failure);
                      print(message);
                    },
                        (offers)async*{
                      yield GoToOfferListState(offers: offers);
                    }
                );
          }
      );

    }
    if(event is CounterOfferEvent){
      yield LoadingState();
      CounterOfferParams counterOfferParams = CounterOfferParams(
        token: event.token,
        id: event.idOffer,
        amount: event.price,
        endsAt: event.dateLimit
      );
      final failureOrOffers = await counterOffer(counterOfferParams);
      yield* failureOrOffers.fold(
              (failure)async*{
            String message= _mapFailureToMessage(failure);
            print("melbloc");
            print(message);
          },
              (offers)async*{
                GetAllByPropertiesParams getAllByPropertiesParams = GetAllByPropertiesParams(
                  token: event.token,
                  id: event.idProp,
                );
                final failureOrOffers = await getOffersByProperties(getAllByPropertiesParams);
                yield* failureOrOffers.fold(
                        (failure)async*{
                      String message= _mapFailureToMessage(failure);
                      print(message);
                    },
                        (offers)async*{
                      yield GoToOfferListState(offers: offers);
                    }
                );
          }
      );

    }
    if(event is GoToSendMessageEvent){
      yield GoToSendMessageState(sender: event.sender);
    }
  }
  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    if(failure is ServerFailure){
      return failure.message;
    }else{
      return 'Unexpected Failure';
    }
  }
}
