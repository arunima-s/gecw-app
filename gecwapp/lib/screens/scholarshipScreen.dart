import 'package:flutter/material.dart';
import 'package:gecwapp/Models/scholarshipModel.dart';
import 'package:gecwapp/customWidgets/scholarshipItem.dart';
import 'package:gecwapp/screens/LoginScreens/loginScreen.dart';

class ScholarShipScreen extends StatefulWidget {
  // const ScholarShipScreen({Key? key}) : super(key: key);

  @override
  State<ScholarShipScreen> createState() => _ScholarShipScreenState();
}

class _ScholarShipScreenState extends State<ScholarShipScreen> {
  var dataset = ScholarshipModel.scholarshipData;
  List<ScholarshipModel> _foundItems = [];

  // var search
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              // TextField(
              //   onChanged: (value) => _runFilter(value),
              //   decoration: const InputDecoration(
              //       labelText: 'Search', suffixIcon: Icon(Icons.search)),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                              color: Color.fromARGB(255, 189, 189, 189)))),
                ),
              )
////////////////
///////////////////
///////////////////
              ,
              SizedBox(
                height: 20,
              ),
              Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  // physics: ClampingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20);
                  },
                  itemCount: _foundItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ScholarshipItem(_foundItems[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // This list holds the data for the list view
  @override
  initState() {
    // at the beginning, all users are shown
    _foundItems = dataset;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<ScholarshipModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = dataset;
    } else {
      results = dataset
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
}

// class ScholarshipScreen extends StatelessWidget {
//   final dataset = ScholarshipModel.scholarshipData;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: ScrollPhysics(),
//           child: Column(
//             children: [
//               TextField(
//                 onChanged: (value) => _runFilter(value),
//                 decoration: const InputDecoration(
//                     labelText: 'Search', suffixIcon: Icon(Icons.search)),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),

//                   // physics: ClampingScrollPhysics(),
//                   separatorBuilder: (BuildContext context, int index) {
//                     return SizedBox(height: 20);
//                   },
//                   itemCount: dataset.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ScholarshipItem(dataset[index]);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // This list holds the data for the list view
//   // List<Map<String, dynamic>> _foundUsers = [];
//   // @override
//   // initState() {
//   //   // at the beginning, all users are shown
//   //   _foundUsers = _allUsers;
//   //   super.initState();
//   // }

//   // This function is called whenever the text field changes
//   void _runFilter(String enteredKeyword) {
//     List<ScholarshipModel> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = dataset;
//     } else {
//       results = dataset
//           .where((item) =>
//               item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }

//     // Refresh the UI
//     // setState(() {
//     //   _foundUsers = results;
//     // });
//   }
// }
