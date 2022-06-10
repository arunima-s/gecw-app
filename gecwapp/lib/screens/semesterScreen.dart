import 'package:flutter/material.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';

class StudyMaterialsScreen extends StatefulWidget {
  const StudyMaterialsScreen({Key? key}) : super(key: key);

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  var selectedCategoryString = "Hello";
  var categoryNames = ["Hello", "World", "Myr"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("uHuhuhuh"),
            DropdownButton(
              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
              value: selectedCategoryString,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: categoryNames.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCategoryString = newValue.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


// class SemesterScreen extends StatelessWidget {
//   // const SemesterScreen({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: ListView(
//       //   // crossAxisAlignment: CrossAxisAlignment.center,
//       //   children: [
//       //     Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //       children: [
//       //         StudyMenuItem("assets/images/notes.png", "S1"),
//       //         StudyMenuItem("assets/images/notes.png", "Book Bicycle"),
//       //       ],
//       //     ),
//       //     Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //       children: [
//       //         StudyMenuItem("assets/images/notes.png", "Notes"),
//       //         StudyMenuItem("assets/images/notes.png", "Syllabus"),
//       //       ],
//       //     ),
//       //     Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //       children: [
//       //         StudyMenuItem("assets/images/notes.png", "Notes"),
//       //         StudyMenuItem("assets/images/notes.png", "Notes"),
//       //       ],
//       //     )
//       //   ],
//       // ),
//       body: Column(),
//     );
//   }
// }


    // return Container(
    //   child: ListView(
    //     shrinkWrap: true,
    //     physics: ClampingScrollPhysics(),
    //     children: [
    //       Row(
    //         children: [
    //           StudyMenuItem("assets/images/notes.png", "Notes"),
    //           StudyMenuItem("assets/images/notes.png", "Syllabus"),
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           StudyMenuItem("assets/images/notes.png", "Notes"),
    //           StudyMenuItem("assets/images/notes.png", "Notes"),
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           StudyMenuItem("assets/images/notes.png", "Notes"),
    //           StudyMenuItem("assets/images/notes.png", "Notes"),
    //         ],
    //       )
    //     ],
    //   ),
    // );