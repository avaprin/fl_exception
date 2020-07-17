import 'dart:async';
import 'dart:io';

import 'package:flexception/src/blocs/bloc.dart';
import 'package:flexception/src/services/data.dart';
import 'file:///D:/Hakaton/fl_exception/lib/src/ui/widgets/buttons/sidebar_button_widget.dart';
import 'file:///D:/Hakaton/fl_exception/lib/src/ui/widgets/buttons/sidebar_local_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_pages_widget.dart';
import 'my_programs_widget.dart';

class SideBar extends StatefulWidget {
  Data data;

  SideBar({Key key, this.data}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Data get data => widget.data;
  List<Widget> apps = List();
  List<Widget> links = List();
  String app = "";
  MainBloc _mainBloc;

  @override
  void initState() {
    data.linksList.forEach((link) {
      links.add(SideBarButton(iconAddress: link.imageLink, title: link.name));
    });
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        generateAppsList();
      });
    });
  }

  void generateAppsList() {
    apps.clear();
    data.appsList.forEach((app) {
      if (app.isAccepted) {
        apps.add(SideBarButton(iconAddress: app.imageLink, title: app.name));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: MediaQuery.of(context).size.height - 60,
      child: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 15),
            child: SvgPicture.asset('icons/Logo.svg'),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(3),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Поиск',
                contentPadding: EdgeInsets.only(top: 10),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(170, 170, 170, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                prefixIcon: SvgPicture.asset(
                  'icons/search.svg',
                  height: 40,
                ),
                filled: true,
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                fillColor: Color.fromRGBO(200, 200, 200, 0.2),
                errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height - 170,
            child: ListView(
              children: [
                Divider(color: Color.fromRGBO(158, 168, 174, 1), height: 1),
                GestureDetector(
                  onTap: (() {
                    _mainBloc.dispatch(ToStart());
                  }),
                  child: SideBarLocalButton('icons/home.svg', 'Рабочее время'),
                ),
                MyPrograms(apps),
                MyPages(links),
                SizedBox(
                  height: 20,
                ),
                Divider(color: Color.fromRGBO(158, 168, 174, 1), height: 1),
                SideBarLocalButton('icons/settings.svg', 'Настройки'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
