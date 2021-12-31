import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(LoginParams loginParams);
/*  Future<Either<Failure, User>> loginGoogle(String test);
  Future<Either<Failure, User>> loginFacebook(String test);*/
  Future<Either<Failure, String>> register(RegisterParams registerParams);
  Future<Either<Failure, User>> getProfile(String token);
  Future<Either<Failure, User>> getUserById(GetUserByIdParams getUserByIdParams);
  Future<Either<Failure, List<String>>> getDepartments();
  Future<Either<Failure, String>> getUserPicture(String token);
  Future<Either<Failure, String>> smsConfirm(String code);
  Future<Either<Failure, GoogleSignInAccount>> loginGoogle();
  Future<Either<Failure, String>> loginFacebook();
}