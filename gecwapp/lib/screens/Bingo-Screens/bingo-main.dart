import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class BingoMain extends StatefulWidget {
  final roomId;
  BingoMain(this.roomId);

  @override
  State<BingoMain> createState() => _BingoMainState();
}

class _BingoMainState extends State<BingoMain> {
  var myTaps = [];
  var opTaps = [];
  // var firstLoad = false;
  List<int> dataList = [];
  List<List<int>> matrix = [];
  @override
  Widget build(BuildContext context) {
    if (dataList.isEmpty) {
      dataList = createRandomMap();
      matrix = createEmptyMatrix();

      // firstLoad = true;
    }
    fetchData();
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    var totalIndex = -1;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: ListView.separated(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 15);
          },
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 40,
              width: screenWidth,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 5);
                },
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  totalIndex = totalIndex + 1;
                  final number = dataList[totalIndex];
                  Color bgColor = Colors.white;
                  Color txtColor = Colors.orange;
                  if (opTaps.contains(number)) {
                    bgColor = Colors.red;
                    txtColor = Colors.white;
                  } else if (myTaps.contains(number)) {
                    bgColor = Colors.orange;
                    txtColor = Colors.white;
                  }
                  return CircleButton(() {
                    numberTapped(number);
                  }, dataList[totalIndex], bgColor, txtColor);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  List<int> createRandomMap() {
    List<int> list = [];
    while (list.length < 25) {
      Random random = new Random();
      int randomNumber = random.nextInt(25);
      if (!list.contains(randomNumber + 1)) {
        list.add(randomNumber + 1);
      }
    }
    print(list);
    return list;
  }

  List<List<int>> createEmptyMatrix() {
    var matrix = [
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ];
    print(matrix);
    return matrix;
  }

  void updateMatrix(int index) {
    var bingo = 0;
    var count = 0;
    final x = index ~/ 5;
    final y = index % 5;
    print("-------------$index");
    matrix[x][y] = 1;
    print(matrix);

    // while (bingo) {
    //           if (matrix[i][j] == 1) {
    //       count++;
    //     } else if (matrix[i][j] == 0) {
    //       j = 4;
    //       count = 0;
    //     }
    // }

    //Horizontal
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        if (matrix[i][j] == 1) {
          count++;
          if (count == 5) {
            count = 0;
            bingo++;
            // bingo = true;
          }
          // print(count);
        } else if (matrix[i][j] == 0) {
          j = 4;
          count = 0;
          // print(count);
        }
      }
    }

    //Vertical
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        if (matrix[i][j] == 1) {
          count++;
          if (i != 4) {
            i++;
            j--;
          } else {
            if (j != 4) {
              i = 0;
              // j--;
            }
          }

          if (count == 5) {
            count = 0;
            bingo++;
          }
        } else {
          if (j != 4) {
            i = 0;
            // j =4;
          } else {
            i = 4;
          }
        }
      }
    }

    //Diagonal
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        if (matrix[i][j] == 1) {
          count++;
          i++;
          if (count == 5) {
            count = 0;
            bingo++;
          }
        }
      }
    }

    if (bingo == 5) {
      Messages.displayMessage(context, "BINGO");
    }

    print(bingo);
  }

  Future fetchData() async {
    final roomRef = await FirebaseDatabase.instance
        .reference()
        .child('rooms')
        .child(widget.roomId);

    roomRef.child('opTap').onValue.listen((event) {
      final snapShot = event.snapshot;
      if (!opTaps.contains(snapShot.value)) {
        setState(() {
          opTaps.add(snapShot.value);
        });
      }
      print(opTaps);
    });
  }

  Future numberTapped(int number) async {
    final roomRef = await FirebaseDatabase.instance
        .reference()
        .child('rooms')
        .child(widget.roomId);
    roomRef.child('myTap').set(number).whenComplete(() {
      setState(() {
        myTaps.add(number);
      });
      updateMatrix(dataList.indexOf(number));
    });
  }

  void checkForBingo() {}
}

// class CircleButton extends StatefulWidget {
//   // const CircleButton({Key? key}) : super(key: key);
//   final GestureTapCallback onTap;
//   final Color bgColor, textColor;
//   final int number;
//   CircleButton(this.onTap, this.number, this.bgColor, this.textColor);

//   @override
//   State<CircleButton> createState() => _CircleButtonState();
// }

// class _CircleButtonState extends State<CircleButton> {
//   @override
//   Widget build(BuildContext context) {
//     double size = 50.0;
//     return new InkResponse(
//       onTap: widget.onTap,
//       child: new Container(
//         width: size,
//         height: size,
//         decoration: new BoxDecoration(
//           border: Border.all(color: Colors.orange),
//           color: widget.bgColor,
//           shape: BoxShape.circle,
//         ),
//         child: Center(
//           child: Text(
//             widget.number.toString(),
//             style: TextStyle(color: widget.textColor),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Color bgColor, textColor;
  final int number;
  CircleButton(this.onTap, this.number, this.bgColor, this.textColor);
  // const CircleButton({Key key, this.onTap, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;
    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.orange),
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
