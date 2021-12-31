import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Message/domain/entities/message.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThreds.dart';

abstract class MessageRemoteDataSource{
  Future<MessageThreads> getMessagesThreads(String token);
  Future<MessageThread> getMessagesThread(GetMessageThreadParams getMessageThreadParams);
  Future<Message> sendMessage(SendMessageParams sendMessageParams);
}