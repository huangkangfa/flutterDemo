import 'package:flutter/material.dart';
import 'package:hello_world/util/util_screen.dart';

class StackToTop extends StatelessWidget {
  final Function onTap;

  StackToTop({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(onTap!=null){
          onTap();
        }
      },
      child: ClipOval(
        child: Image.asset(
          'images/icon_to_top.png',
          height: ScreenUtil().setWidth(50),
          width: ScreenUtil().setWidth(50),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
