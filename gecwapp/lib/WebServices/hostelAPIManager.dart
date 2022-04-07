import 'package:gecwapp/Models/hostelListModel.dart';

// class HostelAPIManager {
//   static List<HostelListModel> fetchHostelList() {
//     return [];
//   }
// }

import 'package:firebase_database/firebase_database.dart';
// import 'message.dart';

class HostelAPIManager {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child('messages');

  void saveMessage(HostelListModel hostelListModel) {
    _messagesRef.push().set(hostelListModel.toJson());
  }

  Query getMessageQuery() {
    return _messagesRef;
  }
}
