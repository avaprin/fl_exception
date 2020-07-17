import 'dart:async';
import 'dart:convert';

import 'package:flexception/src/services/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Model extends StatefulWidget {
  Data data;

  Model({Key key, this.data}) : super(key: key);

  @override
  _ModelState createState() => _ModelState();
}

class _ModelState extends State<Model> {
  Data get _data => widget.data;

  List<Map<String, dynamic>> _users = List();
  List<Map<String, dynamic>> _chats = List();

  DateTime start;

  @override
  void initState() {
    _users.add({"id": 515018939, "access_hash": "4998776154536308183"});
    for(int i = 0; i < 9; ++i){
      _users.add({"id": _data.usersTgList.elementAt(i).id, "access_hash": _data.usersTgList.elementAt(i).accessHash});
    }
    _data.groupChatsTgList.forEach((element) {
      _users.add({"id": element.id, "access_hash": element.accessHash});
    });
    super.initState();
  }

  Future<http.Response> startProcessing() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    http.post(
      'http://127.0.0.1:3004/api/processing/start',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'train': false,
        "apps": ["Teams", "Telegram", "slack", "flexception", "chrome"],
        "links": ["vk.com", "stackoverflow.com"]
      }),
    );
    Timer(Duration(seconds: 10), () async {
      final response = await http.post(
        'http://127.0.0.1:3004/api/processing/predict',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "model_name": "test",
          "python": true,
          "use_mobile": true,
          "date_from": formattedDate,
          "date_to": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          "apps": ["Teams", "Telegram", "slack", "flexception", "chrome"],
          "links": ["vk.com", "stackoverflow.com"]
        }),
      );
      if(response.statusCode==200){
        isActive(json.decode(response.body)["predictions"]);
      }
      http.post(
        'http://127.0.0.1:3004/api/telegram/mute',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "mute_time": 120,
          "users": _users,
          "chats": _chats
        }),
      );
    });
  }

  void isActive(List<dynamic> predictions){
    predictions.forEach((element) {
      print(element);
      if(element==1){
        setState(() {
          _data.isActive = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (() {
          startProcessing();
        }),
        child: Container(
          padding: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 0.0),
              // 10% of the width, so there are ten blinds.
              colors: [
                const Color.fromRGBO(253, 110, 106, 1),
                const Color.fromRGBO(255, 198, 0, 1)
              ], // whitish to gray
            ),
          ),
          width: 440,
          height: 83,
          child: Text(
            "Начать мониторинг",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
      ),
    );
  }
}
