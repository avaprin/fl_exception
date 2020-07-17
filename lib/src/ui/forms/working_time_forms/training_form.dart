import 'dart:convert';

import 'package:flexception/src/services/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrainingForm extends StatefulWidget {
  Data data;

  TrainingForm({Key key, this.data}) : super(key: key);

  @override
  _TrainingFormState createState() => _TrainingFormState();
}

class _TrainingFormState extends State<TrainingForm> {
  Data get _data => widget.data;
  bool animation = false;
  bool isStarted = false;
  bool isActive = true;
  var response;
  List<String> _apps = List();
  TextEditingController modelName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startTraining() {
    _apps.clear();
    _data.appsList.forEach((element) {
      if (element.isAccepted) {
        _apps.add(element.processName);
      }
    });
    http.post(
      'http://127.0.0.1:3004/api/processing/dataset',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "apps": _apps,
        "links": ["vk.com", "stackoverflow.com"]
      }),
    );
    http.post(
      'http://127.0.0.1:3004/api/processing/train',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "apps": _apps,
        "links": ["vk.com", "stackoverflow.com"],
        "model_name": modelName.text,
        "python": true
      }),
    );
  }

  void start() async {
    _apps.clear();
    _data.appsList.forEach((element) {
      if (element.isAccepted) {
        _apps.add(element.processName);
      }
    });
    setState(() {
      isStarted = !isStarted;
    });
    if (isStarted) {
      http.post(
        'http://127.0.0.1:3004/api/processing/start',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'train': true,
          "apps": _apps,
          "links": ["vk.com", "stackoverflow.com"]
        }),
      );
    } else {
      final stopResponse = await http.post(
        'http://127.0.0.1:3004/api/processing/stop',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'train': true,
        }),
      );
      response = await http.post(
        'http://127.0.0.1:3004/api/processing/json',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "apps": _apps,
          "links": ["vk.com", "stackoverflow.com"],
          'train': true,
          "use_mobile": true
        }),
      );
      if (response.statusCode == 200) {
        addAppsTime(json.decode(response.body)["apps"]);
        addLinksTime(json.decode(response.body)["links"]);
        _data.maxTime = json.decode(response.body)["max_time"];
        print(_data.maxTime);
      } else {
        throw Exception('Failed to load apps');
      }
    }
  }

  void addAppsTime(List<dynamic> apps) {
    apps.forEach((element) {
      _data.appsList.forEach((app) {
        if (element["name"] == app.processName) {
          app.time = element["minutes_spent"];
          print(app.name);
        }
      });
    });
  }

  void addLinksTime(List<dynamic> links) {
    links.forEach((element) {
      _data.linksList.forEach((link) {
        if (element["name"] == link.name) {
          link.time = element["minutes_spent"];
          print(link.name);
        }
      });
    });
  }

  void workingMode() {
    http.post(
      'http://127.0.0.1:3004/api/processing/status',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"active": isStarted}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width - 300,
        height: MediaQuery.of(context).size.height - 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color.fromRGBO(158, 168, 174, 1), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          width: 440,
                          height: 83,
                          duration: Duration(seconds: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: animation
                                      ? Colors.white
                                      : Color.fromRGBO(46, 234, 234, 0.5),
                                  spreadRadius: 5,
                                  blurRadius: 4, // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(top: 25),
                              child: Text(
                                "Начать тренировку",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 23),
                              ),
                            ),
                            onTap: (() {
                              setState(() {
                                animation = true;
                                print(animation.toString());
                              });
                              startTraining();
                            }),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 6),
                          height: 83,
                          width: animation ? 440 : 0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(53, 152, 219, 0.7),
                                    spreadRadius: 3,
                                    blurRadius: 7 // changes position of shadow
                                    ),
                              ],
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(53, 152, 219, 0.7)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 440,
                    height: 95,
                    margin: EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: 83,
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 157, 86, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(250, 157, 86, 1),
                                  spreadRadius: 3,
                                  blurRadius: 4 // changes position of shadow
                                  ),
                            ],
                          ),
                          child: Text(
                            "Сбор данных",
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: (() {
                                start();
                              }),
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                alignment: Alignment.center,
                                width: 120,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: isStarted
                                      ? Color.fromRGBO(193, 38, 66, 1)
                                      : Color.fromRGBO(38, 193, 149, 1),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: isStarted
                                            ? Color.fromRGBO(193, 38, 66, 1)
                                            : Color.fromRGBO(38, 193, 149, 1),
                                        spreadRadius: 3,
                                        blurRadius:
                                            2 // changes position of shadow
                                        ),
                                  ],
                                ),
                                child: Text(
                                  isStarted ? "Завершить" : "Начать",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                      child: Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Установить вставить "В работе"',
                            style: TextStyle(
                                color: Color.fromRGBO(158, 168, 174, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Switch(
                          activeColor: Color.fromRGBO(38, 193, 149, 1),
                          value: isActive,
                          onChanged: (bool state) {
                            setState(() {
                              isActive = state;
                            });
                            workingMode();
                          },
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: modelName,
                      style: TextStyle(color: Colors.black),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Наименование сети',
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromRGBO(200, 200, 200, 0.2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Имя',
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromRGBO(200, 200, 200, 0.2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Фамилия',
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromRGBO(200, 200, 200, 0.2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Сфера разработки',
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromRGBO(200, 200, 200, 0.2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
