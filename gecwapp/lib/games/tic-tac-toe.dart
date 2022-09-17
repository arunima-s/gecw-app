import 'package:flutter/material.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:provider/provider.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TappableCell(),
                VerLine(),
                TappableCell(),
                VerLine(),
                TappableCell()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [HorLine(), HorLine(), HorLine()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TappableCell(),
                VerLine(),
                TappableCell(),
                VerLine(),
                TappableCell()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [HorLine(), HorLine(), HorLine()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TappableCell(),
                VerLine(),
                TappableCell(),
                VerLine(),
                TappableCell()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TappableCell extends StatefulWidget {
  const TappableCell({Key? key}) : super(key: key);

  @override
  State<TappableCell> createState() => _TappableCellState();
}

class _TappableCellState extends State<TappableCell> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("object");
        setState(() {
          isTapped = true;
        });
      },
      child: Container(
        color: Colors.white,
        height: 40,
        width: 40,
        child: isTapped ? Icon(Icons.close) : SizedBox(),
      ),
    );
  }
}

// class TappableCell extends StatelessWidget {
//   const TappableCell({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         // color: Colors.white,
//         height: 40,
//         width: 40,
//         child: Icon(Icons.close),
//       ),
//     );
//   }
// }

class HorLine extends StatelessWidget {
  const HorLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 2,
      width: 40,
    );
  }
}

class VerLine extends StatelessWidget {
  // const HorLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 40,
      width: 2,
    );
  }
}
