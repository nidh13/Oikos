import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Message/domain/entities/message.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThreds.dart';

abstract class MessageRepository{
  Future<Either<Failure,MessageThreads>> getMessagesThreads(String token);
  Future<Either<Failure,MessageThread>> getMessagesThread(GetMessageThreadParams getMessageThreadParams);
  Future<Either<Failure,Message>> sendMessage(SendMessageParams sendMessageParams);
}