import 'dart:convert';
import 'dart:io';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/data/models/user_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import '../user_remote_data_source.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({@required this.client});

  @override
  Future<String> login(LoginParams loginParams) async {
    print("lena");
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/security/signin");
   final response = await client.post(url,body: json.encode({
     'emailOrPhone': loginParams.emailOrPhone,
     'password': loginParams.password
   },

   ),headers: {
     "content-type" : "application/json",
     "accept" : "application/json",
   },
   );
    if(response.statusCode ==200){
      final token = json.decode(response.body)['token'];
      print(token);
      return token;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> register(RegisterParams registerParams) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/security/signup/seller");
    final response = await client.post(url,
      body:  json.encode({
         'email': registerParams.email,
         'password': registerParams.password,
         'firstName': registerParams.firstName,
         'lastName': registerParams.lastName,
         'departmentNumber': registerParams.departmentNumber,
         'birthDate': registerParams.birthDate,
         'street': registerParams.street,
         'zipCode': registerParams.zipCode,
         'phoneNumber': registerParams.phoneNumber,
       }) ,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
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
  Future<User> getProfile(String token) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/user/me");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print(response.body);
      final user = UserModel.fromJson(json.decode(response.body));
      return user;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(message);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<List<String>> getDepartments() async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/public/departments");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
    },
    );
    if(response.statusCode ==200){
      final  data = json.decode(response.body);
      final departments = data.map((e) => e['name'].toString()).toList();
      return List<String>.from(departments);
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> getUserPicture(String token) async {
    print("d5alett !!!");
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/user/me/picture");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      File file = json.decode(response.body);
      print(file);
    //  print (message);
   //   return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<GoogleSignInAccount> loginGoogle() async {
    try{
      final response =await GoogleSignIn().signIn();
      return response;
    }catch(error){
      print(error);
    }

  }

  @override
  Future<String> loginFacebook() async {
    //await FacebookAuth.i.logOut();
    final result = await FacebookAuth.i.login(
      permissions: ['email', 'public_profile', 'user_birthday'],
    );
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.i.getUserData(
        fields: "name,email,picture",
      );
      print(userData);
      return("ok");
    }
  }

  @override
  Future<User> getUserById(GetUserByIdParams getUserByIdParams) async {
    var id = getUserByIdParams.id;
    var token = getUserByIdParams.token;
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/user/$id");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
      'Authorization': 'Bearer $token',
    },
    );
    if(response.statusCode ==200){
      print("okk");
      final user = UserModel.fromJson(json.decode(response.body));
      return user;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      print(response.body);
      throw ServerExeption(message: message);
    }
  }

  @override
  Future<String> smsConfirm(String code) async {
    var url = Uri.parse("http://197.13.15.233:8787/api/v1/security/smsconfirm/$code");
    final response = await client.get(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
    },
    );
    if(response.statusCode ==200){
      final message = json.decode(response.body)['message'];
      print("ok");
      print (message);
      return message;
    }else {
      final message = json.decode(response.body)["apierror"]['message'];
      throw ServerExeption(message: message);
    }
  }

}


