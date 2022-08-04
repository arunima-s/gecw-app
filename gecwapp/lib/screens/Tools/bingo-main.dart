import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class BingoMain extends StatefulWidget {
  const BingoMain({Key? key}) : super(key: key);

  @override
  State<BingoMain> createState() => _BingoMainState();
}

class _BingoMainState extends State<BingoMain> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    final dataList = createRandomMap();
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
                  return CircleButton(() {}, dataList[totalIndex].toString());
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
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String number;
  CircleButton(this.onTap, this.number);
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
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(color: AppColors.systemWhite),
          ),
        ),
      ),
    );
  }
}
