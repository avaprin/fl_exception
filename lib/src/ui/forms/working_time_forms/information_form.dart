import 'package:flexception/src/blocs/information_bloc/information_bloc.dart';
import 'package:flexception/src/blocs/information_bloc/information_bloc_helper.dart';
import 'package:flexception/src/blocs/information_bloc/information_event.dart';
import 'package:flexception/src/blocs/information_bloc/information_state.dart';
import 'package:flexception/src/services/data.dart';
import 'file:///D:/Hakaton/fl_exception/lib/src/ui/widgets/buttons/working_time_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationForm extends StatefulWidget {
  Data data;
  InformationForm({Key key, this.data}) : super(key: key);

  @override
  _InformationFormState createState() => _InformationFormState();
}

class _InformationFormState extends State<InformationForm> {

  Data get _data => widget.data;

  InformationBloc _informationBloc;
  InformationBlocHelper _helper;

  @override
  void initState() {
    super.initState();
    _informationBloc = BlocProvider.of<InformationBloc>(context);
    _helper = InformationBlocHelper();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _informationBloc,
      listener: (BuildContext context, InformationState state) {},
      child: BlocBuilder(
          bloc: _informationBloc,
          builder: (BuildContext context, InformationState state) {
            print("main state: " + state.toString());
            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Рабочее время",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: ((){
                              _informationBloc.dispatch(ToSchedule());
                              print(state.toString());
                            }),
                            child:  WorkingTimeButton(state.toString(), "ScheduleState", "График работы"),
                          ),
                        ),
                        Container(
                          width: 150,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: ((){
                              _informationBloc.dispatch(ToTraining());
                              print(state.toString());
                            }),
                            child:  WorkingTimeButton(state.toString(), "TrainingState", "Тренировка сети"),
                          ),
                        ),
                        Container(
                          width: 150,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: ((){
                              _informationBloc.dispatch(ToProgramList());
                              print(state.toString());
                            }),
                            child:  WorkingTimeButton(state.toString(), "ProgramListState", "Список программ"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _helper.informationWidget(state, _data),
                ],
              ),
            );
          }),
    );

  }
}
