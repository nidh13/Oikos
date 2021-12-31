import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/features/Service/data/datasources/services_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:oikosmobile/features/Service/domain/entities/order.dart';

class ServiceDataSourceImpl implements ServiceRemoteDataSource{
  final http.Client client;

  ServiceDataSourceImpl({@required this.client});

  @override
  Future<Orders> getServices(String token) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/orders/me");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print("body kmla");
      print(response.body);
      final orders = Orders.fromJson(json.decode(response.body));
      // print(notifications.content[0].dateCreation);
      return orders;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> payServices(PayParams params) async {
    var token =params.token;
    var id = params.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/orders");
    final response = await client.post(url,body:  json.encode({
      'serviceID': id,
      'paymentMethod': "BankTransfer",
    }) , headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print("cv from payService");
      return "ok cv";
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }


}