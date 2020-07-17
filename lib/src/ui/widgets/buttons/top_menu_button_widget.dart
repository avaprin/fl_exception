import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopMenuButton extends StatelessWidget {
  final String _state;
  final String _isActive;
  final String _title;

  TopMenuButton(this._state, this._isActive, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _title,
        style: TextStyle(
          color: _state == _isActive
              ? Colors.white
              : Color.fromRGBO(158, 168, 174, 1),
          fontSize: _state == _isActive ? 20 : 16,
        ),
      ),
    );
  }
}
