import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Singin/domain/repositories/user_repository.dart';

class GetDepartments extends UseCase<List<String>,NoParams>{
  final UserRepository userRepository;
  GetDepartments(this.userRepository);
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await userRepository.getDepartments();
  }

}