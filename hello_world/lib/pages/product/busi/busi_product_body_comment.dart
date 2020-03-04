
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/util/util_screen.dart';

class ProductComment extends StatelessWidget {

  final ModelProductEntity data;

  ProductComment(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(data==null||data.productCommentCountReponseList.length==0){
      return Container(
        margin: EdgeInsets.only(bottom: ThemeSize.marginSizeMid),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(ThemeSize.marginSizeMid),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(ThemeSize.marginSizeMid),
                child: Text('评价',style: TextStyle(fontSize: ThemeSize.fontSizeMid)),
              ),
              Expanded(flex: 1, child: Center()),
              Text('暂无评价',style: TextStyle(fontSize: ThemeSize.fontSizeMin,color: Colors.grey))
            ],
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: ThemeSize.marginSizeMid),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(ThemeSize.marginSizeMid),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(ThemeSize.marginSizeMid),
              child: Text('评价',style: TextStyle(fontSize: ThemeSize.fontSizeMid)),
            ),
            Expanded(flex: 1, child: Center()),
            Text('查看全部 >',style: TextStyle(fontSize: ThemeSize.fontSizeMin,color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
