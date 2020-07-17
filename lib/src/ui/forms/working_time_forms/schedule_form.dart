import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/ui/widgets/process_time_info.dart';
import 'package:flexception/src/ui/widgets/task_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleForm extends StatefulWidget {
  Data data;

  ScheduleForm({Key key, this.data}) : super(key: key);

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  Data get _data => widget.data;
  List<Widget> tabs = List();

  @override
  void initState() {
    // TODO: implement initState
    tabs.clear();
    _data.appsList.forEach((element) {
      if(element.time>0 && element.isAccepted){
        tabs.add(ProcessTime(
          averageTime: element.time/_data.maxTime,
          currentTime: element.time,
          imageUrl: element.imageLink,
          r: element.r,
          g: element.g,
          b: element.b,
        ));
      }
    });
    _data.linksList.forEach((element) {
      if(element.time>0){
        tabs.add(ProcessTime(
          averageTime: element.time/_data.maxTime,
          currentTime: element.time,
          imageUrl: element.imageLink,
          r: element.r,
          g: element.g,
          b: element.b,
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TaskList(
            data: _data,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height - 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text("Рабочий процесс",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Программы",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(158, 168, 174, 1)),
                          ),
                        ),
                        Container(
                          child: Text("Затраченное время",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(158, 168, 174, 1))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height - 350,
                    child: ListView(
                      children: tabs,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
