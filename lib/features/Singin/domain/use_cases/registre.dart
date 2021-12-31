import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class Register extends UseCase<String, RegisterParams> {
  final UserRepository userRepository;

  Register(this.userRepository);

  @override
  Future<Either<Failure, String>> call(RegisterParams registerParams) async {
    return await userRepository.register(registerParams);
  }

}
