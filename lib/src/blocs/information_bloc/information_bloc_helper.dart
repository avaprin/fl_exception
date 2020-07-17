import 'package:flexception/src/blocs/information_bloc/information_state.dart';
import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/forms/working_time_forms/program_list_form.dart';
import 'package:flexception/src/ui/forms/working_time_forms/schedule_form.dart';
import 'package:flexception/src/ui/forms/working_time_forms/training_form.dart';
import 'package:flutter/material.dart';

class InformationBlocHelper {
  Widget informationWidget(InformationState state, Data data) {
    Widget widget;
    switch(state.toString()){
      case "ScheduleState": {
        widget = ScheduleForm(data: data);
        return widget;
      }
      break;
      case "TrainingState": {
        widget = TrainingForm(data: data);
        return widget;
      }
      break;
      case "ProgramListState": {
        widget = ProgramListForm(data: data);
        return widget;
      }
      break;
    }
  }
}