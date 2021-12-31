import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/features/Service/domain/entities/order.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';

@immutable
abstract class ServiceState extends Equatable {
  ServiceState([List props = const <dynamic>[]]) : super();
}

class InitialServiceState extends ServiceState {
  final Orders orders;

  InitialServiceState({@required this.orders});
  @override
  List<Object> get props => [orders];
}
class LoadingServiceState extends ServiceState {
  @override
  List<Object> get props => [];
}
class GoToOnBoardingState extends ServiceState {
  final List<Pack> packs;

  GoToOnBoardingState({@required this.packs});
  @override
  List<Object> get props => [packs];
}
class GoToPickDateState extends ServiceState {
  final List<Pack> packs;
  final Pack pack ;
  GoToPickDateState({@required this.packs,@required this.pack});
  @override
  List<Object> get props => [packs,pack];
}
class GoToPickPackState extends ServiceState {
  final List<Pack> packs;
  GoToPickPackState({@required this.packs});
  @override
  List<Object> get props => [packs];
}
class GoToPackDisplayState extends ServiceState {
  final List<Pack> packs;
  final Pack pack ;
  GoToPackDisplayState({@required this.packs,@required this.pack});
  @override
  List<Object> get props => [packs,pack];
}
class GoToPickLocationState extends ServiceState {
  final List<Pack> packs;
  GoToPickLocationState({@required this.packs});
  @override
  List<Object> get props => [packs];
}
class GoToPickTimeState extends ServiceState {
  final FullCalendarDay date ;
  final List<Pack> packs;
  final Pack pack ;
  GoToPickTimeState({@required this.date,@required this.packs,@required this.pack});
  @override
  List<Object> get props => [date,packs,pack];
}
class GoToPickPropInformationState extends ServiceState {
  final FullCalendarDay date ;
  final String time;
  final List<Pack> packs;
  final Pack pack ;
  GoToPickPropInformationState({@required this.date,@required this.time,@required this.packs,@required this.pack});
  @override
  List<Object> get props => [date,time,packs,pack];
}
class GoToPropInformationDisplayState extends ServiceState {
  @override
  List<Object> get props => [];
}
