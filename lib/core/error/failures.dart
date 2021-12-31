import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message});
  @override
  List<Object> get props => [message];

}