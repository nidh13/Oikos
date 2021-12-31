import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Message/data/datasources/message_remote_data_source.dart';
import 'package:oikosmobile/features/Message/domain/entities/message.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThreds.dart';
import 'package:oikosmobile/features/Message/domain/repositories/message-repository.dart';

class MessageRepositoryImpl implements MessageRepository{
  final MessageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  MessageRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo});

  @override
  Future<Either<Failure, MessageThread>> getMessagesThread(GetMessageThreadParams getMessageThreadParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getMessagesThread(getMessageThreadParams);
      if (response is MessageThread) {
        print("ok ok ok");
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, MessageThreads>> getMessagesThreads(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getMessagesThreads(token);
      if (response is MessageThreads) {
        print("ok ok ok");
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(SendMessageParams sendMessageParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.sendMessage(sendMessageParams);
      if (response is Message) {
        print("ok ok ok");
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }


}