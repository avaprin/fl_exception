import 'package:flexception/src/blocs/information_bloc/information_bloc.dart';
import 'package:flexception/src/blocs/main_bloc.dart';
import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/forms/main_form.dart';
import 'package:flexception/src/ui/forms/working_time_forms/information_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationScreen extends StatelessWidget {
  Data data;

  InformationScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<InformationBloc>(
        builder: (context) => InformationBloc(),
        child: InformationForm(data: data),
      ),
    );
  }
}
