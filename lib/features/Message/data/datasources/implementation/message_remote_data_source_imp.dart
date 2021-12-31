import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/features/Message/data/datasources/message_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:oikosmobile/features/Message/domain/entities/message.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThreds.dart';

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final http.Client client;

  MessageRemoteDataSourceImpl({@required this.client});

  @override
  Future<MessageThread> getMessagesThread(GetMessageThreadParams getMessageThreadParams) async {
    var token =getMessageThreadParams.token;
    var id = getMessageThreadParams.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/messages/threads/$id");
    final response = await client.get(url, headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      final thread = MessageThread.fromJson(json.decode(response.body));
      return thread;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<MessageThreads> getMessagesThreads(String token) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/messages/threads");
    final response = await client.get(url, headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      final threads = MessageThreads.fromJson(json.decode(response.body));
      return threads;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<Message> sendMessage(SendMessageParams sendMessageParams) async {
    String token =sendMessageParams.token;
    String recipientId = sendMessageParams.senderId;
    String content =sendMessageParams.content;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/messages");
    final response = await client.post(url,body: json.encode({
      "recipientId": recipientId,
      "content": content
    },
    ),headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      final message = Message.fromJson(json.decode(response.body));
      return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }


}