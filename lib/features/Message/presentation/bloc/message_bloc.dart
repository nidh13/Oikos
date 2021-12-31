import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Message/domain/usecases/getMessageThread.dart';
import 'package:oikosmobile/features/Message/domain/usecases/getMessageThreads.dart';
import 'package:oikosmobile/features/Message/domain/usecases/sendMessage.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/use_cases/getUserById.dart';
import './bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessagesThreads getMessagesThreads;
  final GetMessagesThread getMessagesThread;
  final GetUserById getUserById;
  final SendMessage sendMessage;
  MessageBloc({@required this.getMessagesThreads,@required this.getMessagesThread,@required this.getUserById,@required this.sendMessage}) : super(InitialMessageState());
  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is GoToFirstPageEvent) {
      yield LoadingState();
      final failureOrThreads = await getMessagesThreads(event.token);
      yield* failureOrThreads.fold(
              (failure)async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
              (threads)async*{
                 if(threads.content.isNotEmpty){
                   for (var one in threads.content){
                     GetUserByIdParams getUserByIdParams =GetUserByIdParams(token: event.token,id: one.recipientID);
                     final failureOrUser = await getUserById(getUserByIdParams);
                     yield* failureOrUser.fold(
                             (failure)async*{
                           String message= _mapFailureToMessage(failure);
                           print(message);
                         },
                             (user)async*{
                           threads.users.add(user);
                         }
                     );
                   }
                   for (var one in threads.content){
                     GetMessageThreadParams getUserByIdParams =GetMessageThreadParams(token: event.token,id: one.id);
                     final failureOrThread = await getMessagesThread(getUserByIdParams);
                     yield* failureOrThread.fold(
                             (failure)async*{
                           String message= _mapFailureToMessage(failure);
                           print(message);
                         },
                             (thread)async*{
                               thread.id =one.id;
                           threads.listMessageThread.add(thread);
                         }
                     );
                   }
                 }
                 yield  FirstPageState(messageThreads: threads);
          }
      );

    }
    if (event is GoToMessageDisplayEvent) {
      yield MessageDisplayState(messageThread: event.messageThread,sender: event.sender);
    }
    if (event is GoToMessageDisplayFromOtherFeatureEvent) {
      SendMessageParams sendMessageParams =SendMessageParams(token: event.token, senderId: event.sender.id, content: "test");
      yield LoadingState();
      final failureOrMessage = await sendMessage(sendMessageParams);
      yield* failureOrMessage.fold(
              (failure)async*{
            String message= _mapFailureToMessage(failure);
            print(message);
          },
              (message)async*{
                GetMessageThreadParams getUserByIdParams =GetMessageThreadParams(token: event.token,id: message.threadId);
                final failureOrThread = await getMessagesThread(getUserByIdParams);
                yield* failureOrThread.fold(
                        (failure)async*{
                      String message= _mapFailureToMessage(failure);
                      print(message);
                    },
                        (thread)async*{
                          thread.id =message.threadId;
                          yield GoToMessageDisplayFromOtherFeatureState(sender: event.sender,messageThread: thread);
                    }
                );
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
