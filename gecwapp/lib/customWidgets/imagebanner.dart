import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String _assetPath;
  final double imageWidth;
  final double imageHeight;
  ImageBanner(this._assetPath, this.imageHeight, this.imageWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // child: Image.network(
        //   _assetPath,
        //   width: imageWidth,
        //   height: imageHeight,
        //   fit: BoxFit.fill,
        // )
        child: CachedNetworkImage(
          imageUrl: _assetPath,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
