import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThreds.dart';
import 'package:oikosmobile/features/Message/domain/repositories/message-repository.dart';

class GetMessagesThreads extends UseCase<MessageThreads,String>{
  final MessageRepository messageRepository;

  GetMessagesThreads(this.messageRepository);
  @override
  Future<Either<Failure, MessageThreads>> call(String params) async {
    return await messageRepository.getMessagesThreads(params);
  }

}