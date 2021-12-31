import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class MessageEvent extends Equatable {
  MessageEvent([List props = const <dynamic>[]]) : super();
}

class GoToFirstPageEvent extends MessageEvent {
  final String token;

  GoToFirstPageEvent({@required this.token});
  @override
  List<Object> get props => [this.token];
}
class GoToMessageDisplayEvent extends MessageEvent {
  final MessageThread messageThread;
  final User sender;

  GoToMessageDisplayEvent({@required this.messageThread,@required this.sender});

  @override
  List<Object> get props => [messageThread,sender];
}
class GoToMessageDisplayFromOtherFeatureEvent extends MessageEvent {
  final String token;
  final User sender;
  GoToMessageDisplayFromOtherFeatureEvent({@required this.sender,@required this.token});
  @override
  List<Object> get props => [sender,token];
}