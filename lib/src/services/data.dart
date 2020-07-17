import 'package:flexception/src/services/models/GroupChatTg.dart';
import 'package:flexception/src/services/models/link_model.dart';
import 'package:flexception/src/services/models/user_tg_model.dart';

import 'models/app_model.dart';
import 'models/note_model.dart';

class Data {
  List<App> appsList = List();
  List<Link> linksList = List();
  List<Note> notesList = List();
  List<UserTG> usersTgList = List();
  List<GroupChatTg> groupChatsTgList = List();
  bool isActive = false;
  int maxTime = 1;

  void fetchApps(List<dynamic> apps) {
    apps.forEach((element) {
      appsList.add(App(
          name: element["name"],
          processName: element["process_name"],
          imageLink: element["image_link"],
          r: element["r"],
          g: element["g"],
          b: element["b"]));
    });
  }

  void fetchLinks(List<dynamic> links) {
    links.forEach((element) {
      linksList.add(Link(
          name: element["name"],
          imageLink: element["image_link"],
          r: element["r"],
          g: element["g"],
          b: element["b"]));
    });
  }

  void fetchNotes(List<dynamic> notes) {
    notes.forEach((element) {
      notesList.add(Note(element["name"], element["image_link"]));
    });
  }

  void fetchUsersTg(List<dynamic> users) {
    usersTgList.clear();
    users.forEach((element) {
      usersTgList.add(UserTG(
          element["id"],
          element["access_hash"],
          element["first_name"],
          element["last_name"],
          element["username"],
          element["image_url"]));
    });
  }

  void fetchGroupChatsTg(List<dynamic> chats) {
    groupChatsTgList.clear();
    chats.forEach((element) {
      groupChatsTgList.add(GroupChatTg(element["id"], element["username"],
          element["title"], element["image_url"], element["access_hash"]));
    });
  }
}
