import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_refresh_list.dart';

class ShoppingMallPage extends StatefulWidget {
  ShoppingMallPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShoppingMallPageState();
  }
}

class ShoppingMallPageState extends State<ShoppingMallPage>
    with AutomaticKeepAliveClientMixin<ShoppingMallPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: baseAppbar(context, '商城', Center(), Center()),
      body: RefreshList(
          TypeOfGridView(2,
              mainAxisSpacing: ScreenUtil().setWidth(10),
              childAspectRatio: 0.7,
              crossAxisSpacing: ThemeSize.marginSizeMin,
              paddingLeft: ThemeSize.marginSizeMax,
              paddingRight: ThemeSize.marginSizeMax),
          Apis.products_home, (item, index) {
        return buildItemLayoutOfProduct(
            ModelItemProductEntity().fromJson(item));
      }),
    );
  }

  Widget buildItemLayoutOfProduct(ModelItemProductEntity product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1.5, color: Colors.grey[300])),
        ),
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

  @override
  bool get wantKeepAlive => true;
}
