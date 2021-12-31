import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/features/Offer/data/datasources/offer_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:oikosmobile/features/Offer/domain/entities/offers_model.dart';

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource{
  final http.Client client;

  OfferRemoteDataSourceImpl({@required this.client});

  @override
  Future<Offer> acceptOffer(GetAllByPropertiesParams getAllByProperties) async {
    var token =getAllByProperties.token;
    var id = getAllByProperties.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/offers/$id/accept");
    final response = await client.get(url, headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode ==200){
      final offer = Offer.fromJson(json.decode(response.body));
      return offer;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<Offer> counterOffer(CounterOfferParams counterOfferParams) async {
    var token =counterOfferParams.token;
    print("token lena");
    print(token);
    var id = counterOfferParams.id;
    print(id);
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/offers/$id/counter");
    final response = await client.post(url,body:  json.encode({
      'endsAt': counterOfferParams.endsAt,
      'amount': counterOfferParams.amount,
    }) , headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      final offer = Offer.fromJson(json.decode(response.body));
      return offer;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<Offers> getAllByProperties(GetAllByPropertiesParams getAllByProperties) async {
    var token =getAllByProperties.token;
    var id = getAllByProperties.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/$id/offers");
    final response = await client.get(url, headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      final offers = Offers.fromJson(json.decode(response.body));
      return offers;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<Offer> rejectOffer(GetAllByPropertiesParams getAllByProperties) async {
    var token =getAllByProperties.token;
    var id = getAllByProperties.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/offers/$id/reject");
    final response = await client.get(url, headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      final offer = Offer.fromJson(json.decode(response.body));
      return offer;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }
}