import 'package:flexception/src/blocs/bloc.dart';
import 'package:flexception/src/services/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TelegramOne extends StatefulWidget {
  Data data;

  TelegramOne({Key key, this.data}) : super(key: key);
  @override
  _TelegramOneState createState() => _TelegramOneState();
}

class _TelegramOneState extends State<TelegramOne> {

  Data get _data => widget.data;

  TextEditingController _numberController = TextEditingController();
  MainBloc _mainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset('icons/telegram.svg', width: 35, height: 35,),
        title: Text("Telegram", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: Color.fromRGBO(0, 145, 200, 1),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Войти',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Пожалуйста, выберите страну и введите полный номер телефона',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(158, 168, 174, 1),
                ),
              ),
            ),
            Container(
              width: 350,
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    'Номер телефона',
                    style: TextStyle(),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 200,
                    height: 20,
                    child: TextFormField(
                      controller: _numberController,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(46, 168, 227, 1),
                      blurRadius: 10.0,
                      // has the effect of softening the shadow
                      //spreadRadius: 10.0, // has the effect of extending the shadow
                      offset: Offset(0, 4))
                ],
                color: Color.fromRGBO(46, 168, 227, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FlatButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  //_mainBloc.dispatch(ToTelegramSecond());
                },
                textColor: Colors.white,
                disabledTextColor: Colors.white54,
                child: const Text('Далее',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Source Sans pro'
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}