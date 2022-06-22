import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/customWidgets/hostelListItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostelListScreen extends StatefulWidget {
  // const HostelListScreen({Key? key}) : super(key: key);

  @override
  State<HostelListScreen> createState() => _HostelListScreenState();
}

class _HostelListScreenState extends State<HostelListScreen> {
  var hostelData = [];
  var userAccess;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHostelList();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    print(userAccess);
    return Scaffold(
        body: hostelData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hostels",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          userAccess == 2
                              ? IconButton(
                                  onPressed: null, icon: Icon(Icons.edit))
                              : SizedBox()
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 20);
                        },
                        itemCount: hostelData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HostelListItem(hostelData[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  // Fetch hostels
  Future<void> getHostelList() async {
    final databaseRef =
        FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.hostels)
        .once()
        .then((DataSnapshot snapshot) {
      final data = snapshot.value as List<dynamic>;
      print(data);
      final hostels = data.map((e) => HostelListModel.fromJson(e)).toList();
      setState(() {
        hostelData = hostels;
        // hostelData = message;
      });
      // snapshot.value
    });
  }

  getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    int? stringValue = prefs.getInt(SharedKeys.userAccess);
    setState(() {
      userAccess = stringValue;
    });
    // return stringValue;
  }
}

// class HostelListScreen extends StatelessWidget {

// }