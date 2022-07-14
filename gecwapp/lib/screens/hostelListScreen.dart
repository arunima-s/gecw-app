import 'package:flutter/material.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Providers/hostels_provider.dart';
import 'package:gecwapp/Providers/sharedPrefs_provider.dart';
import 'package:gecwapp/customWidgets/hostelListItem.dart';
import 'package:provider/provider.dart';

class HostelListScreen extends StatefulWidget {
  @override
  State<HostelListScreen> createState() => _HostelListScreenState();
}

class _HostelListScreenState extends State<HostelListScreen> {
  List<HostelListModel> hostelData = [];
  int userAccess = 0;
  List<HostelListModel> _foundItems = [];

  // This list holds the data for the list view
  @override
  initState() {
    // hostelData = context.watch<HostelProvider>().hostels;
    // userAccess = context.watch<SharedPrefsProvider>().userAccess;
    // context.read<HostelProvider>().fetchUserDetails();

    // _foundItems = dataset;
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hostelData = context.watch<HostelProvider>().hostels;
    int userAccess = context.watch<SharedPrefsProvider>().userAccess;
    if (hostelData.isEmpty) {
      context.read<HostelProvider>().fetchUserDetails();
    }

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
                    //////////
                    ////////
                    ///////////Search bar

                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                        child: TextField(
                          onChanged: (value) => _runFilter(value),
                          textAlign: TextAlign.left,
                          // controller: _controller,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              hintText: "Search",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 189, 189, 189)))),
                        )),
                    /////
                    ////////
                    ///List Body

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
                          itemCount: _foundItems.length,
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

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<HostelListModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = hostelData;
    } else {
      results = hostelData
          .where((item) =>
              item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundItems = results;
    });
  }

  editHostel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Swantham aayi cheyy myre"),
    ));
  }
}





// class HostelListScreen extends StatelessWidget {
//   var hostelData = [];

//   @override
//   Widget build(BuildContext context) {
//     hostelData = context.watch<HostelProvider>().hostels;
//     int userAccess = context.watch<SharedPrefsProvider>().userAccess;
//     if (hostelData.isEmpty) {
//       context.read<HostelProvider>().fetchUserDetails();
//     }

//     return Scaffold(
//         body: hostelData.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             : SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Hostels",
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold),
//                           ),
//                           userAccess == 2
//                               ? IconButton(
//                                   onPressed: () {
//                                     editHostel(context);
//                                   },
//                                   icon: Icon(Icons.edit))
//                               : SizedBox()
//                         ],
//                       ),
//                     ),
//                     //////////
//                     ////////
//                     ///////////Search bar

//                     Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
//                         child: TextField(
//                           // onChanged: (value) => _runFilter(value),
//                           textAlign: TextAlign.left,
//                           // controller: _controller,
//                           decoration: InputDecoration(
//                               suffixIcon: Icon(Icons.search),
//                               hintText: "Search",
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(25.0),
//                                   borderSide: BorderSide(
//                                       width: 1,
//                                       color:
//                                           Color.fromARGB(255, 189, 189, 189)))),
//                         )),
//                     /////
//                     ////////
//                     ///List Body

//                     Expanded(
//                       child: RefreshIndicator(
//                         onRefresh:
//                             context.read<HostelProvider>().fetchUserDetails,
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           // physics: ClampingScrollPhysics(),
//                           separatorBuilder: (BuildContext context, int index) {
//                             return SizedBox(height: 20);
//                           },
//                           itemCount: hostelData.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return HostelListItem(index);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ));
//   }

//   editHostel(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text("Swantham aayi cheyy myre"),
//     ));
//   }
// }
