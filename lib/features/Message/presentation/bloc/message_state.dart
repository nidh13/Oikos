import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Message/domain/entities/messageThreds.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

@immutable
abstract class MessageState extends Equatable {
  MessageState([List props = const <dynamic>[]]) : super();
}

class InitialMessageState extends MessageState {
  final MessageThreads messageThreads;

  InitialMessageState({@required this.messageThreads});
  @override
  List<Object> get props => [messageThreads];
}
class FirstPageState extends MessageState {
  final MessageThreads messageThreads;
  FirstPageState({@required this.messageThreads});
  @override
  List<Object> get props => [messageThreads];
}
class MessageDisplayState extends MessageState {
  final MessageThread messageThread;
  final User sender;

  MessageDisplayState({@required this.messageThread,@required this.sender});
  @override
  List<Object> get props => [messageThread,sender];
}
class GoToMessageDisplayFromOtherFeatureState extends MessageState {
  final MessageThread messageThread;
  final User sender;

  GoToMessageDisplayFromOtherFeatureState({@required this.messageThread,@required this.sender});
  @override
  List<Object> get props => [messageThread,sender];
}
class LoadingState extends MessageState {
  @override
  List<Object> get props => [];
}