import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/datasets.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:gecwapp/screens/Tools/sgpa-calculator.dart';
import 'package:provider/provider.dart';

class SGPADialog extends StatefulWidget {
  // const SemesterAlert({Key? key}) : super(key: key);

  @override
  State<SGPADialog> createState() => _SGPADialogState();
}

class _SGPADialogState extends State<SGPADialog> {
  var selectedSemesterString = "S3";
  var semesterNames = ["S1 - S2", "S3", "S4", "S5", "S6", "S7", "S8"];
  var selectedDepartmentString = "EEE";
  List<String> departmentNames = [];
  var selectedSubject = "";
  List<String> subjectList = [];
  var data = {1: "EEE", 2: "EC", 3: "MECH", 4: "CS"};

  @override
  void initState() {
    // TODO: implement initState
    departmentNames = data.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(
                    "Semester",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: AppColors.systemWhite,
                  border: Border.all(color: AppColors.systemBlack),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: DropdownButton(
                // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                value: selectedSemesterString,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: semesterNames.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSemesterString = newValue.toString();
                    setSubject();
                  });
                },
              ),
            ),
            ////////////////////////////////////
            ///////////////////////////////////
            //////////////////////////////////
            /////////////////////////////////
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(
                    "Department",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              // width: double.infinity,
              width: MediaQuery.of(context).size.width * 0.6,

              decoration: BoxDecoration(
                  color: AppColors.systemWhite,
                  border: Border.all(color: AppColors.systemBlack),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: DropdownButton(
                // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                value: selectedDepartmentString,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: departmentNames.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDepartmentString = newValue.toString();
                    setSubject();
                  });
                },
              ),
            ),
            ////////////////////////////////////
            ///////////////////////////////
            // ElevatedButton(onPressed: openDrive, child: Text("Get notes"))
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RoundedButton('Get Notes', () {
                openSGPAScreen();
              }, screenWidth * 0.4, screenHeight * 0.06),
            )
          ],
        ),
      ),
    );
  }

  void openSGPAScreen() {
    final dep = selectedDepartmentString + selectedSemesterString;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SGPACalculator(dep)));
  }

  void setSubject() {
    final dep = selectedDepartmentString + selectedSemesterString;
    setState(() {
      subjectList =
          DropDownDataset.subjectList[dep]!.map((e) => e.first).toList();
      selectedSubject = subjectList.first;
    });
  }
}
