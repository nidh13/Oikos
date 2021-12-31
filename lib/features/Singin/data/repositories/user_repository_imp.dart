import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/exception.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/core/network/network_info.dart';
import 'package:oikosmobile/features/Singin/data/data_sources/user_remote_data_source.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  UserRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo
  });

  @override
  Future<Either<Failure, String>> login(LoginParams loginParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.login(loginParams);
      if (response is String) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> register(RegisterParams registerParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.register(registerParams);
      if (response is String) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch (e) {
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getProfile(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getProfile(token);
      if (response is User) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch (e) {
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getDepartments() async {
    try{
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getDepartments();
      return Right(response);
    }on ServerExeption catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getUserPicture(String token) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getUserPicture(token);
      if (response is String) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch (e) {
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, GoogleSignInAccount>> loginGoogle() async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.loginGoogle();
      if (response is GoogleSignInAccount) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch (e) {
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> loginFacebook() async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.loginFacebook();
      if (response is String) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch (e) {
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(GetUserByIdParams getUserByIdParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.getUserById(getUserByIdParams);
      if (response is User) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch (e) {
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, String>> smsConfirm(String code) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption(message: "no connection on your Device");
      }
      response = await remoteDataSource.smsConfirm(code);
      if (response is String) {
        return Right(response);
      } else {
        print("left");
        return Left(response);
      }
    } on ServerExeption catch (e) {
      return Left(ServerFailure(message:e.message));
    }
  }

}