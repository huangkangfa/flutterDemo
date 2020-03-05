import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_default.dart';
import 'package:hello_world/configs/app_size.dart';

class PlaceHolderView extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color bgColor;
  final double padding;

  PlaceHolderView(this.width, this.height, {this.radius, this.bgColor,this.padding, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding??AppSize.marginSizeMid),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 5),
        child: Container(
          width: width,
          height: height,
          color: bgColor??Colors.grey[100],
          child: Center(
            child: Image.asset(AppDefault.DEFAULT_IMG_PLACEHOLDER),
          ),
        ),
      ),
    );
  }
}
