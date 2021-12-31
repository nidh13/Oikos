import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'dart:convert';

import 'package:oikosmobile/features/Properties/data/data_sources/properties_remote_data_source.dart';
import 'package:oikosmobile/features/Properties/domain/entities/liste_properties_model.dart';
import 'package:oikosmobile/features/Properties/domain/entities/propertie_model.dart';
import 'package:oikosmobile/features/Properties/domain/entities/typesOfProperties_model.dart';

class PropertiesRemoteDataSourceImpl implements PropertiesRemoteDataSource{
  final http.Client client;

  PropertiesRemoteDataSourceImpl({@required this.client});

  @override
  Future<PropertiesModel> create(CreatePropertiesParams createPropertiesParams) async {
    var token =createPropertiesParams.token;
    print(json.encode(createPropertiesParams.properties.toJson()));
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/create");
    final response = await client.post(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
      body: json.encode(createPropertiesParams.properties.toJson())
    );
    if(response.statusCode ==200){
      print(response.body);
      final properties = PropertiesModel.fromJson(json.decode(response.body));
      print(response.body);
      return properties;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<PropertiesModel> getById(GetPropertiesByIdParams getPropertiesByIdParams) async {
    var token =getPropertiesByIdParams.token;
    var id = getPropertiesByIdParams.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/$id");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      final properties = PropertiesModel.fromJson(json.decode(response.body));
      print(response.body);
      return properties;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<List<PropertiesModel>> myProperties(String token) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/myproperties",);
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      Iterable l = json.decode(response.body);
      List<PropertiesModel> propertiesList = List<PropertiesModel>.from(l.map((model)=> PropertiesModel.fromJson(model)));
      return propertiesList;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      print("mochkla");
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<List<double>> estimate(EstimateParams estimateParams) async {
    var id = estimateParams.id;
    var token = estimateParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/estimer/$id",);
    final response = await client.post(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      final listEstimation = List<double>.from(json.decode(response.body));
      return listEstimation;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<PropertiesModel> update(CreatePropertiesParams createPropertiesParams) async {
    var id = createPropertiesParams.properties.id;
    var token =createPropertiesParams.token;
    PropertiesModel propertiesModel =createPropertiesParams.properties;
    propertiesModel.typepropInt=2;
    print(json.encode(createPropertiesParams.properties.toJson()));
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/$id");
    final response = await client.put(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
        body: json.encode(propertiesModel.toJson())
    );
    if(response.statusCode ==200){
      print(response.body);
      final properties = PropertiesModel.fromJson(json.decode(response.body));
      print(response.body);
      return properties;
    }else {
      print(response.body);
     // final message = json.decode(response.body)["apierror"]['message'];
    //  print(message);
      //throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> uploadPicture(UploadPropImageParams uploadPropImageParams) async {
    var token =uploadPropImageParams.token;
    var path = uploadPropImageParams.image.path;
    var id = uploadPropImageParams.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/upload/$id");
    var request =  http.MultipartRequest('Post', url,);
    request.headers.addAll({
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',

    },);
    request.files.add(await http.MultipartFile.fromPath('file', path));
/*    print('request files: ${request.files}');
    print(request);*/
    var response = await request.send();
    print(response);
    final res = await http.Response.fromStream(response);
    print(res.body);
    if(res.statusCode ==200){
    print("okok");
    final message = json.decode(res.body)['message'];
    print("message");
    return message;
    }else {
    final message = json.decode(res.body)["apierror"]['message'];
    print(res.body);
    throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> deleteImages(DeleteImagesParams deleteImagesParams) async {
    var token =deleteImagesParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/img/");
    final response = await client.delete(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
        body: json.encode(deleteImagesParams.imageId)
    );
    if(response.statusCode ==200){
      final message = json.decode(response.body)['message'];
      print("message");
      return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }

  }

  @override
  Future<List<PropertiesModel>> getAllProperties(String token) async {
    final queryParameters = {
      'pageNo': '0',
      'pageSize': '10',
      'sortBy': 'price',
    };
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/",);
    url.replace(queryParameters: queryParameters);
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      final propertiesList = PropList.fromJson(json.decode(response.body));
      return propertiesList.listProperties;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<List<TypesOfProperties>> getPropertiesTypes(String token) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/typeofprop/findalltypes",);
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      Iterable l = json.decode(response.body);
      List<TypesOfProperties> typesOfProperties = List<TypesOfProperties>.from(l.map((model)=> TypesOfProperties.fromJson(model)));
      return typesOfProperties;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<List<PropertiesModel>> getAllPropertiesWithStatus(GetAllPropertiesWithStatusParams getAllPropertiesWithStatusParams) async {
    var token = getAllPropertiesWithStatusParams.token;
    var status =getAllPropertiesWithStatusParams.status;
    final queryParameters = {
      'status': '$status',
    };
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/myproperties/search/",);
    url.replace(queryParameters: queryParameters);
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      Iterable l = json.decode(response.body);
      List<PropertiesModel> propertiesList = List<PropertiesModel>.from(l.map((model)=> PropertiesModel.fromJson(model)));
      return propertiesList;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<List<PropertiesModel>> getMyPropertiesWithStatus(GetMyPropertiesWithStatusParams getMyPropertiesWithStatusParams) async {
    var token = getMyPropertiesWithStatusParams.token;
    var status =getMyPropertiesWithStatusParams.status;
    final queryParameters = {
      'status': '$status',
    };
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/search/status/",);
    url.replace(queryParameters: queryParameters);
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      Iterable l = json.decode(response.body);
      List<PropertiesModel> propertiesList = List<PropertiesModel>.from(l.map((model)=> PropertiesModel.fromJson(model)));
      return propertiesList;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> deleteProperties(DeleteImPropertiesParams deleteImPropertiesParams) async {
    var token =deleteImPropertiesParams.token;
    var id = deleteImPropertiesParams.id;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/properties/$id");
    final response = await client.delete(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    }
    );
    if(response.statusCode ==200){
      final message = json.decode(response.body)['message'];
      print("message");
      return message;
    }else {
      //final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      //throw ServerExeption(message: message);
    }
  }

}