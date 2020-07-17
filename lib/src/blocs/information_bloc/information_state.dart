import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class InformationState extends Equatable {
  InformationState([List props = const []]) : super(props);
}

class ScheduleState extends InformationState {
  @override
  String toString() => 'ScheduleState';
}

class TrainingState extends InformationState {
  @override
  String toString() => 'TrainingState';
}

class ProgramListState extends InformationState {
  @override
  String toString() => 'ProgramListState';
}