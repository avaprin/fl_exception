import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/forms/telegram_forms/telegram_form.dart';
import 'package:flexception/src/ui/forms/telegram_forms/telegram_second.dart';
import 'package:flexception/src/ui/forms/telegram_forms/tg_enter_registration_form.dart';
import 'package:flexception/src/ui/screens/information_screen.dart';
import 'package:flexception/src/ui/widgets/model_widget.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class MainBlocHelper {
  Widget mainWidget(MainState state, Data data) {
    Widget widget;
    switch (state.toString()) {
      case "StartState":
        {
          widget = InformationScreen(data);
          return widget;
        }
        break;
      case "ModelState":
        {
          widget = Model(data: data);
          return widget;
        }
        break;
      case "TelegramOneState":
        {
          widget = EnterRegister();
          return widget;
        }
        break;
      case "UsersState":
        {
          widget = TelegramForm(data: data,);
          return widget;
        }
        break;
      case "TelegramSecondState":
        {
          TelegramSecondState telegramSecondState = state as TelegramSecondState;
          widget = TelegramSecond(data: data, number: telegramSecondState.number);
          return widget;
        }
        break;
    }
  }
}
