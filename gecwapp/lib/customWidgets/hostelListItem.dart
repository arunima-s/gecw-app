import 'package:flutter/material.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';

class HostelListItem extends StatelessWidget {
  final String _hostelName, _imageName;
  HostelListItem(this._hostelName, this._imageName);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.expand(height: 250.0),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageBanner(_imageName),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Text(_hostelName),
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
