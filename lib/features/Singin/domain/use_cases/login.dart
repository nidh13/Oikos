import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class Login extends UseCase<String, LoginParams> {
  final UserRepository userRepository;

  Login(this.userRepository);

  @override
  Future<Either<Failure, String>> call(LoginParams loginParams) async {
    return await userRepository.login(loginParams);
  }

}