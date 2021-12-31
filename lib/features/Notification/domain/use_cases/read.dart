import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Notification/domain/repositories/notifications_repository.dart';

class Read extends UseCase<String,GetNotificationByIdParams>{
  final NotificationsRepository notificationsRepository;

  Read(this.notificationsRepository);
  @override
  Future<Either<Failure, String>> call(GetNotificationByIdParams params) async {
    return await notificationsRepository.read(params);
  }

}