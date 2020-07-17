import 'package:flexception/src/blocs/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SideBarButton extends StatefulWidget {

  final String iconAddress;
  final String title;

  SideBarButton({Key key, this.iconAddress, this.title}) : super(key: key);

  @override
  _SideBarButtonState createState() => _SideBarButtonState();
}
class _SideBarButtonState extends State<SideBarButton> {

  String get _iconAddress => widget.iconAddress;
  String get _title => widget.title;

  MainBloc _mainBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: ((){
        if(_title=="Telegram"){
          _mainBloc.dispatch(ToTelegramOne());
        }
      }),
      child: Container(
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
                  child: SvgPicture.network(_iconAddress),
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
              child: _title=="Telegram"? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color.fromRGBO(158, 168, 174, 1),
              ): null,
            )
          ],
        ),
      ),
    );
  }
}