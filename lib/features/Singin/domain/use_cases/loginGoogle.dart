import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class LoginGoogle extends UseCase<GoogleSignInAccount, NoParams> {
  final UserRepository userRepository;

  LoginGoogle(this.userRepository);

  @override
  Future<Either<Failure, GoogleSignInAccount>> call(NoParams params) async {
    return await userRepository.loginGoogle();
  }

}