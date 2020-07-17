import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final String _title;
  final String _information;

  NoteWidget(this._title, this._information);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 80,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(53, 152, 219, 1),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(53, 152, 219, 0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(_title, style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(_information, style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
        ],
      )
    );
  }
}
