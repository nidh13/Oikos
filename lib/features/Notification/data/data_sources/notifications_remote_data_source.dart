import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Notification/domain/entities/notifications_model.dart';

abstract class NotificationsRemoteDataSource{
  Future<Notifications> getAll (String token);
  Future<OneNotification> getById (GetNotificationByIdParams getNotificationByIdParams);
  Future<String> read (GetNotificationByIdParams getNotificationByIdParams);
  Future<Notifications> getUnRead (String token);
}