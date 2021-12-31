import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class GetUserById extends UseCase<User,GetUserByIdParams>{
  final UserRepository userRepository;
  GetUserById(this.userRepository);
  @override
  Future<Either<Failure, User>> call(GetUserByIdParams getUserByIdParams) async {
    return await userRepository.getUserById(getUserByIdParams);
  }

}