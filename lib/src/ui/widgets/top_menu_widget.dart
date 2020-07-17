import 'dart:async';

import 'package:flexception/src/blocs/bloc.dart';
import 'package:flexception/src/services/data.dart';
import 'file:///D:/Hakaton/fl_exception/lib/src/ui/widgets/buttons/top_menu_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopMenu extends StatefulWidget {
  String state;
  Data data;

  TopMenu({Key key, this.state, this.data}) : super(key: key);

  @override
  _TopMenuState createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  String get _state => widget.state;

  Data get _data => widget.data;

  MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 160,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: (() {
                _mainBloc.dispatch(ToStart());
              }),
              child: TopMenuButton(_state, "StartState", "Создать модель"),
            ),
          ),
          Container(
            width: 160,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: (() {
                _mainBloc.dispatch(ToModel());
              }),
              child: TopMenuButton(_state, "ModelState", "Модель № 1"),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-750,
          ),
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              'icons/plus.svg',
              color: _data.isActive ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
