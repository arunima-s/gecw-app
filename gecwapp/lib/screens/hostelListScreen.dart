import 'package:flutter/material.dart';
import 'package:gecwapp/Providers/hostels_provider.dart';
import 'package:gecwapp/Providers/sharedPrefs_provider.dart';
import 'package:gecwapp/customWidgets/hostelListItem.dart';
import 'package:provider/provider.dart';

class HostelListScreen extends StatelessWidget {
  var hostelData = [];
  // var userAccess;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getHostelList();
  //   getSharedPrefs();
  // }

  @override
  Widget build(BuildContext context) {
    // context.read<UserProvider>().fetchUserDetails;
    // context.read<NotificationProvider>().getNotifications;
    hostelData = context.watch<HostelProvider>().hostels;
    int userAccess = context.watch<SharedPrefsProvider>().userAccess;
    if (hostelData.isEmpty) {
      context.read<HostelProvider>().fetchUserDetails();
    }

    // print(userAccess);
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
                                  onPressed: () {
                                    editHostel(context);
                                  },
                                  icon: Icon(Icons.edit))
                              : SizedBox()
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh:
                            context.read<HostelProvider>().fetchUserDetails,
                        child: ListView.separated(
                          shrinkWrap: true,
                          // physics: ClampingScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: hostelData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HostelListItem(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  editHostel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Swantham aayi cheyy myre"),
    ));
  }
}
