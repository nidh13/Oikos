import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';

@immutable
abstract class NotificationEvent extends Equatable {
  NotificationEvent([List props = const <dynamic>[]]) : super();
}

class GoToFirstPageEvent extends NotificationEvent {
  final String token;

  GoToFirstPageEvent({@required this.token});
  @override
  List<Object> get props => [token];
}
class ReadEvent extends NotificationEvent {
  final GetNotificationByIdParams getNotificationByIdParams;
  ReadEvent({@required this.getNotificationByIdParams});
  @override
  List<Object> get props => [getNotificationByIdParams];
}
