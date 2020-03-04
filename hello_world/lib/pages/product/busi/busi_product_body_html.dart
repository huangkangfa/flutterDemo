import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/util/util_screen.dart';

class ProductDetailHtml extends StatelessWidget {
  final String htmlData;

  ProductDetailHtml(this.htmlData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (htmlData == null || htmlData == '') {
      return Center();
    }
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(74)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left:ThemeSize.marginSizeMid,right: ThemeSize.marginSizeMid,bottom: ThemeSize.marginSizeMax,top: ThemeSize.marginSizeMax),
              child: Text('详情',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ThemeSize.fontSizeMid),),
            ),
            Html(data: htmlData)
          ],
        ));
  }
}
