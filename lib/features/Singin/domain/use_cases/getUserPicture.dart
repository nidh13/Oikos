import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class GetUserPicture extends UseCase<String,String>{
  final UserRepository userRepository;
  GetUserPicture(this.userRepository);

  @override
  Future<Either<Failure, String>> call(String token) async {
    return await userRepository.getUserPicture(token);
  }


}