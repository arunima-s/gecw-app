import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'package:gecwapp/screens/Tools/bunk-manager-screen.dart';
import 'package:gecwapp/screens/Tools/cgpa-calculator.dart';
import 'package:gecwapp/screens/Tools/sgpa-calculator.dart';
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
            child: AutoSizeText(
              "Tools",
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BunkManagerScreen()))
                      },
                  child:
                      StudyMenuItem("assets/images/bunk.png", "Bunk Manager")),
              GestureDetector(
                  onTap: () {
                    Messages.displayMessage(context, "Feature coming soon....");
                  },
                  child: StudyMenuItem("assets/images/games.png", "Games")),
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
                      "assets/images/cgpa.png", "CGPA Calculator")),
              GestureDetector(
                child:
                    StudyMenuItem("assets/images/sgpa.png", "SGPA Calculator"),
                onTap: () => {
                  showDialog(
                      context: context, builder: (context) => SGPACalculator())
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
