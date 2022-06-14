import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String _assetPath;
  final double imageWidth;
  ImageBanner(this._assetPath, this.imageWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(20)),
        child: Image.network(
        _assetPath,
        width: imageWidth,
        fit: BoxFit.fill,
      ),
      ),

    );
  }
}
