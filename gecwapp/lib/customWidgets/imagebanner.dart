import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String _assetPath;

  ImageBanner(this._assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      // constraints: BoxConstraints.expand(
      //   height: 200.0,
      // ),
      // decoration: BoxDecoration(color: Colors.grey),
      child: ClipRRect(
        borderRadius:
            // BorderRadius.vertical(top: Radius.circular(20)), // Image border
            BorderRadius.all(Radius.circular(20)),
        // child: Image.asset(
        //   _assetPath,
        //   fit: BoxFit.cover,
        // ),
        child: Image.network(
        _assetPath,
        fit: BoxFit.cover,
      ),
      ),

    );
  }
}
