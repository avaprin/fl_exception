import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final response = await http.get('https://test.developmentandscorp.tech/api/apps');
  Data data = Data();
  if (response.statusCode == 200) {
    print("http get successful");
    data.fetchApps(json.decode(response.body)["apps"]);
    data.fetchLinks(json.decode(response.body)["links"]);
  } else {
    throw Exception('Failed to load apps');
  }
  Process.run('powershell', ['Start-Process', 'node', '-ArgumentList', 'index.js', '-WindowStyle', 'Hidden'], workingDirectory:'D:\\Hakaton\\fl_exception\\processingmicroservice_service');
  runApp(MyApp(data: data,));
}

class MyApp extends StatefulWidget {
  Data data;
  MyApp({Key key, this.data}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Data get data => widget.data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(47, 49, 54, 1),
      ),
      home: MainScreen(data),
    );
  }
}
