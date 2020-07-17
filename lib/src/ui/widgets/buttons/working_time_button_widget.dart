import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkingTimeButton extends StatefulWidget {

  String state;
  String isActive;
  String title;

  WorkingTimeButton(this.state, this.isActive, this.title);

  @override
  _WorkingTimeButtonState createState() => _WorkingTimeButtonState();
}

class _WorkingTimeButtonState extends State<WorkingTimeButton> {

  String get _state => widget.state;
  String get _isActive => widget.isActive;
  String get _title => widget.title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: _state == _isActive ? Border(bottom: BorderSide(color: Color.fromRGBO(133, 203, 202, 1), width: 4)): null,
      ),
      child: GestureDetector(
        child: Text(_title, style: TextStyle(fontSize: 18, color: _state == _isActive ? Colors.black : Color.fromRGBO(158, 168, 174, 1)),),
      ),
    );
  }
}