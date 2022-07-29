import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/datasets.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';

class SGPACalculator extends StatelessWidget {
  // const SGPACalculator({Key? key}) : super(key: key);
  final String department;
  SGPACalculator(this.department);
  List<String> subjectList = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    subjectList =
        DropDownDataset.subjectList[department]!.map((e) => e.first).toList();
    return Scaffold(
      body: Container(
        width: screenWidth,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("Semester"), Text("SGPA")],
            ),
            ////
            ListView.separated(
              shrinkWrap: true,
              // physics: ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 5);
              },
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                // if (_foundItems[index].isPta == ptaSelected) {
                return SGPAItem(subjectList[index]);
                // } else {
                //   return SizedBox();
                // }
              },
            ),

            ///
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: RoundedButton("Calculate SGPA", () {
                // print(sgpaList);
                // print(sgpaList.length);
                // if (sgpaList.length != 8) {
                //   Messages.displayMessage(context, "Enter all values");
                // } else {
                //   sgpaList.values.map((e) {
                //     sum = sum + e;
                //   }).toList();
                //   Messages.displayMessage(context, "${sum * 0.125}");
                //   sum = 0;
                // }
              }, screenWidth * 0.5, screenHeight * 0.08),
            )
          ],
        ),
      ),
    );
  }
}

// class SGPAItem extends StatelessWidget {
//   // const CGPAItem({Key? key}) : super(key: key);
//   // final Map sgpaList;
//   final String subject;
//   SGPAItem(this.subject);
//   final TextEditingController _sgpaController = TextEditingController();
//   final gradesList = ['O', 'A+','A', 'B+','B', 'C+','', 'C','P', 'F','FE'];

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = context.watch<GWValuesProvider>().height;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         SizedBox(width: screenHeight * 0.41, child: Text(subject)),
//         SizedBox(
//           width: 100,
//           height: 40,

//           child: DropdownButton(
//                 // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 value: selectedSemesterString,
//                 icon: const Icon(Icons.keyboard_arrow_down),
//                 items: gradesList.map((items) {
//                   return DropdownMenuItem(
//                     value: items,
//                     child: Text(items),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedSemesterString = newValue.toString();
//                     setSubject();
//                   });
//                 },
//               ),
//         ),
//       ],
//     );
//   }
// }

class SGPAItem extends StatefulWidget {
  // const SGPAItem({Key? key}) : super(key: key);
  final String subject;
  SGPAItem(this.subject);
  @override
  State<SGPAItem> createState() => _SGPAItemState();
}

class _SGPAItemState extends State<SGPAItem> {
  final gradesList = ['O', 'A+', 'A', 'B+', 'B', 'C+', 'C', 'P', 'F', 'FE'];
  String selectedGrade = 'O';

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: screenHeight * 0.41, child: Text(widget.subject)),
        SizedBox(
          width: 100,
          height: 40,
          child: DropdownButton(
            // borderRadius: BorderRadius.all(Radius.circular(10.0)),
            value: selectedGrade,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: gradesList.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedGrade = newValue.toString();
                // setSubject();
              });
            },
          ),
        ),
      ],
    );
  }
}
