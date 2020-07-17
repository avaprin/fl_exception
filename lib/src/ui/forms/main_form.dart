import 'dart:collection';
import 'dart:io';

import 'package:flexception/src/blocs/bloc.dart';
import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/widgets/sidebar_widget.dart';
import 'package:flexception/src/ui/widgets/top_menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainForm extends StatefulWidget {

  Data data;

  MainForm({Key key, this.data})
      : super(key: key);

  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  MainBloc _mainBloc;
  MainBlocHelper _helper;

  Data get data => widget.data;

  @override
  void initState() {
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    _helper = MainBlocHelper();
  }

  @override
  void dispose() {
    _mainBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _mainBloc,
      listener: (BuildContext context, MainState state) {},
      child: BlocBuilder(
          bloc: _mainBloc,
          builder: (BuildContext context, MainState state) {
            print("main state: " + state.toString());
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Row(
                children: [
                  SideBar(data: data),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopMenu(state: state.toString(), data: data),
                        Container(
                          width: MediaQuery.of(context).size.width - 350,
                          height: MediaQuery.of(context).size.height - 120,
                          margin: EdgeInsets.only(left: 15, top: 15),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: _helper.mainWidget(state, data),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
