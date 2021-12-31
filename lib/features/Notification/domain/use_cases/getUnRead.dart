import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Usecases/usecases.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Notification/domain/entities/notifications_model.dart';
import 'package:oikosmobile/features/Notification/domain/repositories/notifications_repository.dart';

class GetUnRead extends UseCase<Notifications,String>{
  final NotificationsRepository notificationsRepository;

  GetUnRead(this.notificationsRepository);
  @override
  Future<Either<Failure, Notifications>> call(String params) async {
    return await notificationsRepository.getUnRead(params);
  }

}