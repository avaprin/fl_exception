import 'package:flexception/src/blocs/main_bloc.dart';
import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/forms/main_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {

  Data data;

  MainScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider<MainBloc>(
        builder: (context) => MainBloc(),
        child: MainForm(data: data),
      ),
    );
  }

}