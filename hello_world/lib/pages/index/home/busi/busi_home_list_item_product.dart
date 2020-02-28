import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/util/util_screen.dart';

class ListItemOfProduct extends StatelessWidget {

  final ModelItemProductEntity product;

  ListItemOfProduct(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200], width: 1.0),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Image.network(
                  product.images,
                  fit: BoxFit.fill,
                )),
            Container(
              height: ScreenUtil().setWidth(45),
              child: Padding(
                padding: EdgeInsets.only(
                    left: ThemeSize.marginSizeMid,
                    right: ThemeSize.marginSizeMid),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: ThemeSize.fontSize14,
                          color: ThemeColors.colorFont_333)),
                ),
              ),
            ),
            Container(
              height: ScreenUtil().setWidth(30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: ThemeSize.marginSizeMid,
                        right: ThemeSize.marginSizeMid),
                    child: Text('￥${product.price / 100}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xffff4d7a),
                            fontSize: ThemeSize.fontSize14)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
