import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oikosmobile/core/Utils/calendar.dart';
import 'package:oikosmobile/core/Utils/paramaters.dart';
import 'package:oikosmobile/features/Service/domain/entities/pack_model.dart';

@immutable
abstract class ServiceEvent extends Equatable {
  ServiceEvent([List props = const <dynamic>[]]) : super();
}

class InitialServiceEvent extends ServiceEvent {
  final String token;

  InitialServiceEvent({@required this.token});
  @override
  List<Object> get props => [token];
}
class GoToOnBoardingEvent extends ServiceEvent {
  final List<Pack> packs;
  GoToOnBoardingEvent({@required this.packs});
  @override
  List<Object> get props => [packs];
}
class GoToPickDateEvent extends ServiceEvent {
  final List<Pack> packs;
  final Pack pack ;
  GoToPickDateEvent({@required this.packs,@required this.pack});
  @override
  List<Object> get props => [packs,pack];
}
class GoToPickPackEvent extends ServiceEvent {
  final List<Pack> packs;
  GoToPickPackEvent({@required this.packs});
  @override
  List<Object> get props => [packs];
}
class GoToPackDisplayEvent extends ServiceEvent {
  final List<Pack> packs;
  final Pack pack ;
  GoToPackDisplayEvent({@required this.packs,@required this.pack});
  @override
  List<Object> get props => [packs,pack];
}
class GoToPickLocationEvent extends ServiceEvent {
  final List<Pack> packs;
  GoToPickLocationEvent({@required this.packs});
  @override
  List<Object> get props => [packs];
}
class GoToPickTimeEvent extends ServiceEvent {
  final FullCalendarDay date ;
  final List<Pack> packs;
  final Pack pack ;
  GoToPickTimeEvent({@required this.date,@required this.packs,@required this.pack});
  @override
  List<Object> get props => [date,packs,pack];
}
class GoToPickPropInformationEvent extends ServiceEvent {
  final FullCalendarDay date ;
  final String time;
  final List<Pack> packs;
  final Pack pack ;
  GoToPickPropInformationEvent({@required this.date,@required this.time,@required this.packs,@required this.pack});
  @override
  List<Object> get props => [date,time,packs,pack];
}
class GoToPropInformationDisplayEvent extends ServiceEvent {
  @override
  List<Object> get props => [];
}
class PayPhotoServiceEvent extends ServiceEvent {
  final PayParams payParams;

  PayPhotoServiceEvent({@required this.payParams});
  @override
  List<Object> get props => [payParams];
}