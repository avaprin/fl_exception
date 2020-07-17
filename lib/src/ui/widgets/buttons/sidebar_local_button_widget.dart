import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideBarLocalButton extends StatelessWidget {

  final String _iconAddress;
  final String _title;

  SideBarLocalButton(this._iconAddress, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
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
                  child: SvgPicture.asset(_iconAddress),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  _title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(233, 234, 234, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color.fromRGBO(158, 168, 174, 1),
              ),
            )
          ],
        ),
      );
  }
}