import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @override
  MainState get initialState => StartState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is ToStart) {
      yield* _mapToStartToState();
    }
    if (event is ToModel) {
      yield* _mapToModelToState();
    }
    if (event is ToTelegramOne) {
      yield* _mapToTelegramOneToState();
    }
    if (event is ToTelegramSecond) {
      yield* _mapToTelegramSecondToState(event.number);
    }
    if (event is ToUsers) {
      yield* _mapToUsersToState();
    }
  }

  Stream<MainState> _mapToStartToState() async* {
    yield StartState();
  }

  Stream<MainState> _mapToUsersToState() async* {
    yield UsersState();
  }

  Stream<MainState> _mapToModelToState() async* {
    yield ModelState();
  }

  Stream<MainState> _mapToTelegramOneToState() async* {
    yield TelegramOneState();
  }

  Stream<MainState> _mapToTelegramSecondToState(String number) async* {
    yield TelegramSecondState(number);
  }
}