import 'package:flutter/material.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'package:gecwapp/customWidgets/Alerts/simple-alert.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';

class CGPACalculator extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);
  int sum = 0;
  Map<int, int> sgpaList = {};

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
                Text(
                  "CGPA Calculator",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Semester",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    "SGPA",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
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
                return CGPAItem(index, sgpaList);
                // } else {
                //   return SizedBox();
                // }
              },
            ),

            ///
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: RoundedButton("Calculate CGPA", () {
                sum = 0;

                print(sgpaList);
                print(sgpaList.length);
                if (sgpaList.length != 8) {
                  Messages.displayMessage(context, "Enter all values");
                } else {
                  sgpaList.values.map((e) {
                    sum = sum + e;
                  }).toList();
                  // Messages.displayMessage(context, "${sum * 0.125}");
                  showDialog(
                      context: context,
                      builder: (BuildContext buildContext) {
                        final average = sum * 0.125;
                        return SimpleAlert(
                            "Your CGPA is ${average.toString()}");
                      });
                }
              }, screenWidth * 0.5, screenHeight * 0.08),
            )
          ],
        ),
      ),
    );
  }
}

class CGPAItem extends StatelessWidget {
  // const CGPAItem({Key? key}) : super(key: key);
  final Map sgpaList;
  final int index;
  CGPAItem(this.index, this.sgpaList);
  final TextEditingController _sgpaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Semester ${index + 1}"),
        SizedBox(
          width: 100,
          height: 40,
          child: TextField(
            textInputAction: TextInputAction.next,

            controller: _sgpaController,
            onChanged: (value) {
              if (value == "") {
                sgpaList..remove(index);
              } else {
                final sgpa = int.parse(value);
                if (sgpa > 10) {
                  _sgpaController.text = "10";
                  // Messages.displayMessage(
                  //     context, "Enter a valid sgpa(Between 0 and 10)");
                }
                sgpaList[index] = int.parse(_sgpaController.text);
              }
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            // controller: _controller,
            decoration: InputDecoration(
                // suffixIcon: Icon(Icons.search),
                // hintText: "Search",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                        width: 1, color: Color.fromARGB(255, 189, 189, 189)))),
          ),
        ),
      ],
    );
  }
}
