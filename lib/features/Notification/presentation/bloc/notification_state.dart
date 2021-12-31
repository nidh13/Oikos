import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Notification/domain/entities/notifications_model.dart';

@immutable
abstract class NotificationState extends Equatable {
  NotificationState([List props = const <dynamic>[]]) : super();
}

class InitialNotificationState extends NotificationState {
  @override
  List<Object> get props => [];
}
class LoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}
class FirstPageState extends NotificationState {
  final Notifications notifications;

  FirstPageState({@required this.notifications});
  @override
  List<Object> get props => [notifications];
}
class ReadState extends NotificationState {
  @override
  List<Object> get props => [];
}
