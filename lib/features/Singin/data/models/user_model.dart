import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class UserModel extends User {

  UserModel(
      {@required String id, @required String firstName, @required String lastName,@required String password,@required String email,
        @required String phoneNumber,@required String birthDate,@required String street,@required String zipCode,
        @required String departmentNumber,@required String civility,@required String maritalStatus}
      ):super(id: id,
    firstName: firstName,lastName: lastName,password: password,email: email,phoneNumber: phoneNumber,
  birthDate: birthDate,street: street,zipCode: zipCode,departmentNumber: departmentNumber,civility:civility ,maritalStatus: maritalStatus);
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'] ,
      password: json['password'],
      email: json['email'] ,
      phoneNumber: json['phoneNumber'],
      birthDate: json['birthDate'] ,
      street: json['address'] != null ?json['address']['street']:null,
      zipCode: json['address'] != null ?json['address']['zipCode']:null,
      departmentNumber:json['address'] != null ? json['address']['departmentName']:null,
      civility: json['civility'] ,
      maritalStatus: json['maritalStatus'] ,

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'street': street,
      'zipCode': zipCode,
      'departmentNumber': departmentNumber,
      'civility': civility,
      'maritalStatus': maritalStatus,
    };
  }

}