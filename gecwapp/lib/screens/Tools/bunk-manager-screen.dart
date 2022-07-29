import 'package:flutter/material.dart';

class BunkManagerScreen extends StatefulWidget {
  // const BunkManagerScreen({Key? key}) : super(key: key);

  @override
  State<BunkManagerScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BunkManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: ListView.separated(
        //                     shrinkWrap: true,
        //                     // physics: ClampingScrollPhysics(),
        //                     separatorBuilder: (BuildContext context, int index) {
        //                       return SizedBox(height: 20);
        //                     },
        //                     itemCount: _foundItems.length,
        //                     itemBuilder: (BuildContext context, int index) {
        //                       if (_foundItems[index].isPta == ptaSelected) {
        //                         return HostelListItem(index);
        //                       } else {
        //                         return SizedBox();
        //                       }
        //                     },
        //                   ),,
        );
  }
}
