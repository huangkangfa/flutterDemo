import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hello_world/configs/app_size.dart';
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
              padding: EdgeInsets.only(left:AppSize.marginSizeMid,right: AppSize.marginSizeMid,bottom: AppSize.marginSizeMax,top: AppSize.marginSizeMax),
              child: Text('详情',style: TextStyle(fontWeight: FontWeight.bold,fontSize: AppSize.fontSizeMid),),
            ),
            Html(data: htmlData)
          ],
        ));
  }
}
