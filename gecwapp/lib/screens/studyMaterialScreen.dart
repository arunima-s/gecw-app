import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Screens/semesterScreen.dart';

class HomeScreenMenu extends StatefulWidget {
  const HomeScreenMenu({Key? key}) : super(key: key);

  @override
  State<HomeScreenMenu> createState() => _HomeScreenMenuState();
}

class _HomeScreenMenuState extends State<HomeScreenMenu> {
  var screenType = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Row(
          children: [
            StudyMenuItem("assets/images/notes.png", "Hostels"),
            StudyMenuItem("assets/images/notes.png", "Book Bicycle"),
          ],
        ),
        Row(
          children: [
            GestureDetector(
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudyMaterialsScreen()))
                    },
                child: StudyMenuItem("assets/images/notes.png", "Notes")),
            StudyMenuItem("assets/images/notes.png", "Syllabus"),
          ],
        ),
        Row(
          children: [
            StudyMenuItem("assets/images/notes.png", "Notes"),
            StudyMenuItem("assets/images/notes.png", "Notes"),
          ],
        )
      ],
    );
  }
}

// class StudyMaterialsScreen extends StatelessWidget {
//   // const StudyMaterialsScreen({ Key? key }) : super(key: key);

// }

class StudyMenuItem extends StatelessWidget {
  final String _assetPath, text;
  StudyMenuItem(this._assetPath, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
      height: MediaQuery.of(context).size.width * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.systemWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey3,
                offset: Offset(2.0, 2.0),
                spreadRadius: 3.0,
                blurRadius: 2.0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _assetPath,
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(text)
        ],
      ),
    );
  }
}
