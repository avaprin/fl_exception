import 'file:///D:/Hakaton/fl_exception/lib/src/ui/widgets/buttons/sidebar_button_widget.dart';
import 'package:flutter/material.dart';

class MyPrograms extends StatelessWidget {
  List<Widget> _buttons = List();

  MyPrograms(List<Widget> buttons) {
    buttons.forEach((button) {
      this._buttons.add(button);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _buttons.isNotEmpty,
        child: Container(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin:
                    EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(158, 168, 174, 1),
                            width: 1))),
                child: Text(
                  "Твои программы",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                children: _buttons,
              ),
            ],
          ),
        ));
  }
}
