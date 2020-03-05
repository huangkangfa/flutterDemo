import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/util/util_screen.dart';

class ProductFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(AppSize.marginSizeMid),
        constraints: BoxConstraints(maxHeight: ScreenUtil().setWidth(74)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: AppSize.marginSizeMid),
              child: Item(name: '咨询', icon: Icons.message),
            ),
            Padding(
              padding: EdgeInsets.only(left: AppSize.marginSizeMax),
              child: Item(name: '购物车', icon: Icons.shopping_cart),
            ),
            Padding(
              padding: EdgeInsets.only(left: AppSize.marginSizeMax),
              child: Item(name: '收藏', icon: Icons.collections),
            ),
            Expanded(flex: 1, child: Center()),
            ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(21)),
              child: Row(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xffFE7102),
                            Color(0xffFE854D),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: AppSize.marginSizeMid,
                          bottom: AppSize.marginSizeMid,
                          left: AppSize.marginSizeMax,
                          right: AppSize.marginSizeMid),
                      child:
                          Text('加入购物车', style: TextStyle(color: Colors.white))),
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xffFA5B6A),
                            Color(0xffFD3374),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: AppSize.marginSizeMid,
                          bottom: AppSize.marginSizeMid,
                          left: AppSize.marginSizeMax,
                          right: AppSize.marginSizeMax),
                      child:
                          Text('立即购买', style: TextStyle(color: Colors.white))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final IconData icon;
  final String name;

  Item({@required this.name, @required this.icon, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(icon),
        Text(name, style: TextStyle(fontSize: AppSize.fontSizeMin))
      ],
    );
  }
}
