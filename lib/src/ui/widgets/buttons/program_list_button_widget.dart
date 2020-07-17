import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/services/models/app_model.dart';
import 'package:flexception/src/services/models/link_model.dart';
import 'package:flexception/src/ui/widgets/sidebar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProgramListButton extends StatefulWidget {
  App app;

  ProgramListButton(this.app);

  @override
  _ProgramListButtonState createState() => _ProgramListButtonState();
}

class _ProgramListButtonState extends State<ProgramListButton> {
  App get _app => widget.app;

  SideBar sideBar = SideBar();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _app.isAccepted=!_app.isAccepted;
        });
      },
      child: Container(
        width: 200,
        height: 35,
        padding: EdgeInsets.only(left: 10, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  width: 30,
                  height: 34,
                  child: SvgPicture.network(_app.imageLink),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  _app.name,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              child: _app.isAccepted
                  ? Icon(
                      Icons.check_circle,
                      size: 22,
                      color: Color.fromRGBO(133, 203, 202, 1),
                    )
                  : Icon(
                      Icons.check_circle_outline,
                      size: 22,
                      color: Color.fromRGBO(133, 203, 202, 1),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
