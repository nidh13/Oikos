import 'package:dartz/dartz.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/core/error/failures.dart';
import 'package:oikosmobile/features/Notification/domain/entities/notifications_model.dart';

abstract class NotificationsRepository{
  Future<Either<Failure,Notifications>> getAll(String token);
  Future<Either<Failure,OneNotification>> getById(GetNotificationByIdParams getNotificationByIdParams);
  Future<Either<Failure,String>> read(GetNotificationByIdParams getNotificationByIdParams);
  Future<Either<Failure,Notifications>> getUnRead(String token);
}