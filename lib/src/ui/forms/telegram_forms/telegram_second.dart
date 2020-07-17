import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flexception/src/blocs/bloc.dart';
import 'package:flexception/src/blocs/main_bloc.dart';
import 'package:flexception/src/services/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class TelegramSecond extends StatefulWidget {

  Data data;
  String number;

  TelegramSecond({Key key, this.data, this.number}) : super(key: key);

  @override
  _TelegramSecondState createState() => _TelegramSecondState();
}

class _TelegramSecondState extends State<TelegramSecond> {

  Data get _data => widget.data;
  String get number => widget.number;
  Timer _timer;
  String phoneCodeHash;
  int _start = 60;
  MainBloc _mainBloc;
  var response;
  var codeResponse;

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    askVerification();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
  void askVerification() async {
    response = await http.get('http://127.0.0.1:3004/api/telegram/code?phone_number='+number);
    if (response.statusCode == 200) {
      print("http get successful");
      phoneCodeHash = json.decode(response.body)["phone_code_hash"];
    } else {
      response = await http.get('http://127.0.0.1:3004/api/telegram/code?phone_number='+number);
      phoneCodeHash = json.decode(response.body)["phone_code_hash"];
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            }));
  }

  void checkCode(String code) async {
    codeResponse = await http.post(
      'http://127.0.0.1:3004/api/telegram/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phone_number": number,
        "phone_code_hash": phoneCodeHash,
        "code": code
      }),
    );
    if(codeResponse.statusCode == 200){
      final responseTG = await http.get('http://127.0.0.1:3004/api/telegram/users');
      if (responseTG.statusCode == 200) {
        print("http get USER successful");
        _data.fetchUsersTg(json.decode(responseTG.body)["users"]);
        _data.fetchGroupChatsTg(json.decode(responseTG.body)["chats"]);
        _mainBloc.dispatch(ToUsers());
      } else {
        throw Exception('Failed to load users');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset('icons/telegram.svg', width: 35, height: 35,),
        title: Text("Telegram", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: Color.fromRGBO(0, 145, 200, 1),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            child: Text(number),
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: FlatButton(
              splashColor: Colors.transparent,
              onPressed: () {
                _mainBloc.dispatch(ToTelegramOne());
              },
              textColor: Color.fromRGBO(87, 131, 165, 1),
              disabledTextColor: Colors.white54,
              child: const Text('Изменить номер телефона',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Source Sans pro')),
            ),
          ),
          Center(
            child: Text(
              'Мы отправили вам rод подтверждения.',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(158, 168, 174, 1),
              ),
            ),
          ),
          SizedBox(height: 0),
          Text(
            'Пожалуйста, введите его.',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(158, 168, 174, 1),
            ),
          ),
          Text(
            'Оператор позвонит вам в течении $_start c.',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(158, 168, 174, 1),
            ),
          ),
          Text(
            'Введите ваш код',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(158, 168, 174, 1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 20,
            width: 300,
            child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (String code) {
                if(code.length==5){
                  checkCode(code);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
