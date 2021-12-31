import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class LoginFacebook extends UseCase<String, NoParams> {
  final UserRepository userRepository;

  LoginFacebook(this.userRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await userRepository.loginFacebook();
  }

}