import 'dart:convert';
import 'dart:io';

import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/widgets/buttons/sidebar_button_widget.dart';
import 'package:flexception/src/ui/widgets/buttons/tg_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class TelegramForm extends StatefulWidget {
  Data data;

  TelegramForm({Key key, this.data}) : super(key: key);

  @override
  _TelegramFormState createState() => _TelegramFormState();
}

class _TelegramFormState extends State<TelegramForm> {

  Data get data => widget.data;

  List<Widget> users = List();
  List<Widget> chats = List();
  double time = 1;

  @override
  void initState() {
    print("telegram");
    data.usersTgList.forEach((user) {
      users.add(TGButton(iconAddress: user.imageUrl, title: user.firstName+" "+user.lastName));
    });
    data.groupChatsTgList.forEach((chat) {
      chats.add(TGButton(iconAddress: chat.imageUrl, title: chat.title));
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset('icons/telegram.svg', width: 35, height: 35,),
        title: Text("Telegram", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: Color.fromRGBO(0, 145, 200, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/5,
              height: MediaQuery.of(context).size.height - 220,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(87, 131, 165, 1), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width/5-2,
                    height: 30,
                    child: SvgPicture.asset('icons/contacts.svg'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    height: MediaQuery.of(context).size.height - 275,
                    child: ListView(
                      children: users,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/5,
              height: MediaQuery.of(context).size.height - 220,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(87, 131, 165, 1), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width/5-2,
                    height: 30,
                    child: SvgPicture.asset('icons/groups.svg'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    height: MediaQuery.of(context).size.height - 275,
                    child: ListView(
                      children: chats,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/5,
              height: MediaQuery.of(context).size.height - 220,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(87, 131, 165, 1), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Column(
                  children: [
                    Slider(
                      value: time,
                      onChanged: (newTime){
                        setState(() {
                          time=newTime;
                        });
                      },
                      max: 8,
                      min: 1,
                      label: "Часы",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}