import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/features/Calendar/data/data_sources/diponibility_remote_data_source_imp.dart';
import 'package:http/http.dart' as http;
import 'package:oikosmobile/features/Calendar/domain/entities/disponibility_model.dart';

class DisponibilityRemoteDataSourceImpl implements DisponibilityRemoteDataSource{
  final http.Client client;

  DisponibilityRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<Disponibility>> addMany(AddManyDisponibilityParams addManyDisponibilityParams) async {
    var token =addManyDisponibilityParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/dispo/add");
    var list =  addManyDisponibilityParams.disponibilitys.map((v) => v.toJson()).toList();
    final response = await client.post(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
        body: json.encode(list)
    );
    if(response.statusCode ==200){
      Iterable l = json.decode(response.body);
      List<Disponibility> list = List<Disponibility>.from(l.map((model)=> Disponibility.fromJson(model)));
      return list;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }
}