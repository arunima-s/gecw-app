import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/customWidgets/hostelListItem.dart';


class HostelListScreen extends StatefulWidget {
  // const HostelListScreen({Key? key}) : super(key: key);

  @override
  State<HostelListScreen> createState() => _HostelListScreenState();
}

class _HostelListScreenState extends State<HostelListScreen> {
    var hostelData = [];

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHostelList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                          body: hostelData.isEmpty
                    ? CircularProgressIndicator()
                    : 
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: hostelData.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return HostelListItem(hostelData[index]);
                    //     },
                    //   ),
                    // child:
                     SafeArea(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                             child: Text("Hostels", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
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
                     )
    );
  }

    // Fetch hostels
    Future<void> getHostelList() async {
    final databaseRef = FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef.child('hostels').once().then((DataSnapshot snapshot) {
      
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
}

// class HostelListScreen extends StatelessWidget {

// }