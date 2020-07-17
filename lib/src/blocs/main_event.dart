import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  MainEvent([List props = const []]) : super(props);
}

class ToStart extends MainEvent {
  @override
  String toString() => 'ToStart';
}

class ToModel extends MainEvent {
  @override
  String toString() => 'ToModel';
}

class ToTelegramOne extends MainEvent {
  @override
  String toString() => 'ToTelegramOne';
}

class ToUsers extends MainEvent {
  @override
  String toString() => 'ToUsers';
}

class ToTelegramSecond extends MainEvent {

  String number;

  ToTelegramSecond(this.number);

  @override
  String toString() => 'ToTelegramSecond';
}
