import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class SmsConfirm extends UseCase<String,String>{
  final UserRepository userRepository;
  SmsConfirm(this.userRepository);
  @override
  Future<Either<Failure, String>> call(String code) async {
    return await userRepository.smsConfirm(code);
  }
}