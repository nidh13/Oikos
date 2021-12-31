import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/features/Notification/data/data_sources/notifications_remote_data_source.dart';
import 'package:oikosmobile/features/Notification/domain/entities/notifications_model.dart';
import 'package:http/http.dart' as http;

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource{
  final http.Client client;

  NotificationsRemoteDataSourceImpl({@required this.client});
  @override
  Future<Notifications> getAll(String token) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<OneNotification> getById(GetNotificationByIdParams getNotificationByIdParams) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<Notifications> getUnRead(String token) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/notifications/");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print("body kmla");
      print(response.body);
      final notifications = Notifications.fromJson(json.decode(response.body));
     // print(notifications.content[0].dateCreation);
      return notifications;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> read(GetNotificationByIdParams getNotificationByIdParams) async {
    var id = getNotificationByIdParams.id;
    var token = getNotificationByIdParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/notifications/$id/read");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      final message = json.decode(response.body)['message'];
      return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      throw ServerExeption(message: message);
    }
  }

}