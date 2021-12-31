import 'dart:convert';

import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/features/Profile/data/data_sources/profile_remote_data_source.dart';
import 'package:oikosmobile/features/Profile/domain/entities/userPicture_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  final http.Client client;

  ProfileRemoteDataSourceImpl({@required this.client});
  @override
  Future<UserPicture> updatePicture(UpdateImageParams updateImageParams) async {
    var token =updateImageParams.token;
    print(token);
    var path = updateImageParams.image.path;
    print(path);
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/user/me/picture");
    var request =  http.MultipartRequest('PUT', url,);
    request.headers.addAll({
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',

    },);

    request.files.add(await http.MultipartFile.fromPath('file', path));
    print('request files: ${request.files}');
    print(request);
    var response = await request.send();
    print(response);
    final res = await http.Response.fromStream(response);
    print(res.body);
    if(res.statusCode ==200){
      print("okok");
      final userPicture = UserPicture.fromJson(json.decode(res.body));
      return userPicture;
    }else {
      final message = json.decode(res.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> updatePassword(ResetPasswordParams resetPasswordParams) async {
    var token =resetPasswordParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/user/me");
    final response = await client.post(url,
      body:  json.encode({
        'password': resetPasswordParams.password,
      }) ,headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode ==200){
      final message = json.decode(response.body)['message'];
      print("ok");
      print (message);
      return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> updateProfile(UpdateProfileParams updateProfileParams) async {
    var token =updateProfileParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/user/me");
    final response = await client.put(url,
      body:  json.encode({
        'email': updateProfileParams.email,
        'password': updateProfileParams.password,
        'firstName': updateProfileParams.firstName,
        'lastName': updateProfileParams.lastName,
        'phoneNumber': updateProfileParams.phoneNumber,
        'password':updateProfileParams.password
      }) ,headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode ==200){
      final message = json.decode(response.body)['message'];
      print (message);
      return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
     throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> updateGeneralInformation(UpdateGeneralInformationParams updateGeneralInformationParams) async {
    var token =updateGeneralInformationParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/seller/me");
    print(updateGeneralInformationParams.generalInformationModel.toJson());
    final response = await client.put(url,
      body:  json.encode(updateGeneralInformationParams.generalInformationModel.toJson()) ,headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode ==200){
      final message = json.decode(response.body)['message'];
      print (message);
      return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

}