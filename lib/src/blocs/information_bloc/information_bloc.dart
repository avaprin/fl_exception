import 'dart:async';
import 'package:bloc/bloc.dart';
import 'information_event.dart';
import 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  @override
  InformationState get initialState => ScheduleState();

  @override
  Stream<InformationState> mapEventToState(InformationEvent event) async* {
    if (event is ToSchedule) {
      print("1");
      yield* _mapToScheduleToState();
    }
    if (event is ToTraining) {
      print("2");
      yield* _mapToTrainingToState();
    }
    if (event is ToProgramList) {
      print("3");
      yield* _mapToProgramListToState();
    }
  }

  Stream<InformationState> _mapToScheduleToState() async* {
    yield ScheduleState();
  }

  Stream<InformationState> _mapToTrainingToState() async* {
    yield TrainingState();
  }

  Stream<InformationState> _mapToProgramListToState() async* {
    yield ProgramListState();
  }
}