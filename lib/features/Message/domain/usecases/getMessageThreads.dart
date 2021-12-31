import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/domain/repositories/message-repository.dart';

class GetMessagesThread extends UseCase<MessageThread,GetMessageThreadParams>{
  final MessageRepository messageRepository;

  GetMessagesThread(this.messageRepository);
  @override
  Future<Either<Failure, MessageThread>> call(GetMessageThreadParams params) async {
    return await messageRepository.getMessagesThread(params);
  }

}