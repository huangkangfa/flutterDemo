import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/size.dart';

class PlaceHolderView extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color bgColor;

  PlaceHolderView(this.width, this.height, {this.radius, this.bgColor, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeSize.marginSizeMid),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 5),
        child: Container(
          width: width,
          height: height,
          color: bgColor??Colors.grey[100],
          child: Center(
            child: Image.asset('images/bg_default.png'),
          ),
        ),
      ),
    );
  }
}
