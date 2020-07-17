import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  MainState([List props = const []]) : super(props);
}

class StartState extends MainState {
  @override
  String toString() => 'StartState';
}

class ModelState extends MainState {
  @override
  String toString() => 'ModelState';
}

class TelegramOneState extends MainState {
  @override
  String toString() => 'TelegramOneState';
}

class UsersState extends MainState {
  @override
  String toString() => 'UsersState';
}

class TelegramSecondState extends MainState {

  String number;

  TelegramSecondState(this.number);

  @override
  String toString() => 'TelegramSecondState';
}