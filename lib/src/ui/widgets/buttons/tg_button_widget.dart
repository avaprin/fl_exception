import 'package:flexception/src/blocs/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TGButton extends StatefulWidget {
  final String iconAddress;
  final String title;

  TGButton({Key key, this.iconAddress, this.title}) : super(key: key);

  @override
  _TGButtonState createState() => _TGButtonState();
}

class _TGButtonState extends State<TGButton> {
  String get _iconAddress => widget.iconAddress;

  String get _title => widget.title;

  MainBloc _mainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    print(_iconAddress.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(left: 10, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                width: 34,
                height: 34,
                child: _iconAddress.length == 0
                    ? Image.asset('icons/user.jpg')
                    : Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_iconAddress),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                _title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
