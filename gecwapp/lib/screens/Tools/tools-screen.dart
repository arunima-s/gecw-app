import 'package:flutter/material.dart';
import 'package:gecwapp/Screens/HostelScreens/hostelListScreen.dart';
import 'package:gecwapp/customWidgets/Alerts/sgpa-dialog.dart';
import 'package:gecwapp/screens/Tools/bingo-main.dart';
import 'package:gecwapp/screens/Tools/bunk-manager-screen.dart';
import 'package:gecwapp/screens/Tools/cgpa-calculator.dart';
import 'package:gecwapp/screens/Tools/sgpa-calculator.dart';
import 'package:gecwapp/screens/scholarshipScreen.dart';
import 'package:gecwapp/screens/semesterScreen.dart';
import 'package:gecwapp/screens/studyMaterialScreen.dart';

class ToolSScreen extends StatelessWidget {
  // const ToolSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BunkManagerScreen()))
                      },
                  child: StudyMenuItem(
                      "assets/images/hostel.png", "Bunk Manager")),
              GestureDetector(
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BingoMain()))
                      },
                  child: StudyMenuItem(
                      "assets/images/bicycle.png", "Book Bicycle")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  // onTap: () => {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => StudyMaterialsScreen()))
                  //     },
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => CGPACalculator());
                  },
                  child: StudyMenuItem(
                      "assets/images/syllabus.png", "CGPA Calculator")),
              GestureDetector(
                child: StudyMenuItem(
                    "assets/images/scholarship.png", "SGPA Calculator"),
                onTap: () => {
                  showDialog(
                      context: context, builder: (context) => SGPADialog())
                },
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     GestureDetector(
          //         onTap: () {
          //           showDialog(
          //               context: context,
          //               builder: (context) => StudyMaterialsScreen(false));
          //         },
          //         child: StudyMenuItem("assets/images/notes.png", "Notes")),
          //     GestureDetector(
          //       child: StudyMenuItem("assets/images/notes.png", "Notes"),
          //       onTap: () {
          //         // showNotification();
          //       },
          //     ),
          //   ],
          // )
        ],
      ),
    ));
  }
}
