import 'package:flutter/material.dart';

import 'buttons/sidebar_button_widget.dart';

class MyPages extends StatelessWidget {
  List<Widget> _buttons = List();

  MyPages(List<Widget> buttons) {
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
              margin: EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(158, 168, 174, 1), width: 1))),
              child: Text("Твои Страницы", style: TextStyle(fontSize: 14, color: Colors.white,),),
            ),
            Column(
              children: _buttons,
            ),
          ],
        ),
      ),
    );
  }
}
