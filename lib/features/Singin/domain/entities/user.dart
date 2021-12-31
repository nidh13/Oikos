import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String phoneNumber;
  final String birthDate;
  final String street;
  final String zipCode;
  final String departmentNumber;
  final String civility;
  final String maritalStatus;

  User( {@required this.id,@required this.firstName, @required this.lastName,@required this.password,@required this.email,
      @required  this.phoneNumber,@required this.birthDate,@required this.street,@required this.zipCode,
  @required this.departmentNumber,@required this.civility,@required this.maritalStatus}):super();

  @override
  // TODO: implement props
  List<Object> get props => [id,firstName,lastName,password,email,phoneNumber,birthDate,street,zipCode,departmentNumber,civility,maritalStatus];


}