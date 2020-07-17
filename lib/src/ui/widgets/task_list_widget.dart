import 'package:flexception/src/services/data.dart';
import 'package:flexception/src/services/models/note_model.dart';
import 'package:flexception/src/ui/widgets/note_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  Data data;

  TaskList({Key key, this.data}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  Data get _data => widget.data;

  List<Widget> notes = List();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _informationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _addNoteDialog(BuildContext buildContext) {
    _titleController.clear();
    showDialog(
        context: buildContext,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: TextFormField(
                          controller: _titleController,
                          style: TextStyle(color: Colors.white),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Заголовок',
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
                        height: 50,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: _informationController,
                          style: TextStyle(color: Colors.white),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Описание',
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
                        height: 45,
                        width: 250,
                        margin: EdgeInsets.only(right: 5, left: 5, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.black.withOpacity(0.8),
                            border: Border.all(
                                color: Color.fromRGBO(53, 152, 219, 0.5),
                                width: 2)),
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          onPressed: (() {
                            if((_titleController.text.isNotEmpty)&&(_informationController.text.isNotEmpty)){
                              print(_data.notesList.length);
                              addNote(_titleController.text, _informationController.text);
                              print(_data.notesList.length);
                            }
                            Navigator.pop(context);
                          }),
                          textColor: Colors.white,
                          child: const Text('Добавить',
                              style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  )),
            ],
          );
        });
  }

  void addNote(String title, String information){
    print(_data.notesList.length);
    setState(() {
      _data.notesList.add(Note(title, information));
    });
    print(_data.notesList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height - 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color.fromRGBO(158, 168, 174, 1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Сегодня, " +
                  DateFormat('dd-MM').format(DateTime.now()),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Основные задачи",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 300,
            child: ListView.builder
              (
                itemCount: _data.notesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new NoteWidget(_data.notesList.elementAt(index).title, _data.notesList.elementAt(index).information);
                }
            )
          ),
          GestureDetector(
            onTap: ((){
              _addNoteDialog(context);
            }),
            child: Container(
              height: 35,
              alignment: Alignment.center,
              child: SvgPicture.asset('icons/add_note.svg'),
            ),
          )
        ],
      ),
    );
  }
}
