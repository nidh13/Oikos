import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Notification/domain/use_cases/getUnRead.dart';
import 'package:oikosmobile/features/Notification/domain/use_cases/read.dart';
import './bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetUnRead getUnRead;
  final Read read;
  NotificationBloc({@required this.read,@required this.getUnRead}) : super(LoadingState());


  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is GoToFirstPageEvent) {
     final failureOrNotifications = await getUnRead(event.token);
     yield* failureOrNotifications.fold(
         (failure)async*{
           String message= _mapFailureToMessage(failure);
           print(message);
         },(notifications)async*{
       yield FirstPageState(notifications: notifications);
     }
     );

    }
    if(event is ReadEvent){
      final failureOrString = await read(event.getNotificationByIdParams);
      yield* failureOrString.fold(
              (failure)async*{
                String message= _mapFailureToMessage(failure);
                print(message);
                },
              (string)async*{
                yield ReadState();
              }
      );

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
