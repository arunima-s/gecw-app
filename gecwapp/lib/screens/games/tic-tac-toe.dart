import 'package:flutter/material.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:provider/provider.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    print("-----------");
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
                TappableCell(0
                    // key: Key("0"),
                    ),
                VerLine(),
                TappableCell(1
                    // key: Key("1"),
                    ),
                VerLine(),
                TappableCell(2
                    // key: Key("2"),
                    )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [HorLine(), HorLine(), HorLine()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TappableCell(3
                    // key: Key("3"),
                    ),
                VerLine(),
                TappableCell(4
                    // key: Key("4"),
                    ),
                VerLine(),
                TappableCell(5
                    // key: Key("5"),
                    )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [HorLine(), HorLine(), HorLine()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TappableCell(6
                    // key: Key("6"),
                    ),
                VerLine(),
                TappableCell(7
                    // key: Key("7"),
                    ),
                VerLine(),
                TappableCell(8
                    // key: Key("8"),
                    )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TappableCell extends StatefulWidget {
  // const TappableCell({Key? key}) : super(key: key);
  final index;
  TappableCell(this.index);

  @override
  State<TappableCell> createState() => _TappableCellState();
}

class _TappableCellState extends State<TappableCell> {
  var table = [
    PlayerName.none,
    PlayerName.none,
    PlayerName.none,
    PlayerName.none,
    PlayerName.none,
    PlayerName.none,
    PlayerName.none,
    PlayerName.none,
    PlayerName.none
  ];
  bool p1 = false;
  bool p2 = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // final key = Key('1');
        // print(widget.key.);
        setState(() {
          if (!p1) {
            table[widget.index] = PlayerName.player1;
            p1 = true;
            p2 = false;
          } else {
            table[widget.index] = PlayerName.player2;
            p1 = false;
            p2 = true;
          }
        });
        print(table);
      },
      child: Container(
        color: Colors.white,
        height: 40,
        width: 40,
        // child: isTapped ? Icon(Icons.close) : SizedBox(),
        child: (table[widget.index] == PlayerName.none)
            ? SizedBox()
            : ((table[widget.index] == PlayerName.player1)
                ? Icon(Icons.close)
                : Icon(Icons.circle_outlined)),
      ),
    );
  }
}

enum PlayerName { none, player1, player2 }

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
