import 'package:flexception/src/services/data.dart';
import 'file:///D:/Hakaton/fl_exception/lib/src/ui/widgets/buttons/program_list_button_widget.dart';
import 'package:flutter/cupertino.dart';

class ProgramListForm extends StatefulWidget {

  Data data;

  ProgramListForm({Key key, this.data}) : super(key: key);

  @override
  _ProgramListFormState createState() => _ProgramListFormState();
}

class _ProgramListFormState extends State<ProgramListForm> {

  Data get _data => widget.data;

  List<Widget> apps = List();

  @override
  void initState() {
    _data.appsList.forEach((app) {
      apps.add(ProgramListButton(app));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Flex(
        direction: Axis.vertical,
        children: apps,
      ),
    );
  }
}