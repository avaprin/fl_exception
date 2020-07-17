import 'package:equatable/equatable.dart';

abstract class InformationEvent extends Equatable {
  InformationEvent([List props = const []]) : super(props);
}

class ToSchedule extends InformationEvent {
  @override
  String toString() => 'ToSchedule';
}

class ToTraining extends InformationEvent {
  @override
  String toString() => 'ToSchedule';
}

class ToProgramList extends InformationEvent {
  @override
  String toString() => 'ToProgramList';
}