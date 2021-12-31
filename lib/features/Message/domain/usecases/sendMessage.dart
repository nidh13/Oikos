import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Message/domain/entities/message.dart';
import 'package:oikosmobile/features/Message/domain/repositories/message-repository.dart';

class SendMessage extends UseCase<Message,SendMessageParams>{
  final MessageRepository messageRepository;
  SendMessage(this.messageRepository);
  @override
  Future<Either<Failure, Message>> call(SendMessageParams params) async {
    return await messageRepository.sendMessage(params);
  }
}