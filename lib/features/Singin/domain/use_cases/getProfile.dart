import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class GetProfile extends UseCase<User,String>{
  final UserRepository userRepository;
  GetProfile(this.userRepository);
  @override
  Future<Either<Failure, User>> call(String token) async {
    return await userRepository.getProfile(token);
  }

}