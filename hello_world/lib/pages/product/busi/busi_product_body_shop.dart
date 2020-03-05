import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/util/util_screen.dart';

class ProductDetailShop extends StatelessWidget {
  final ModelProductEntity data;

  ProductDetailShop(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(data==null){
      return Center();
    }
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.marginSizeMid),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(AppSize.marginSizeMid),
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: data.logo,
              width: ScreenUtil().setWidth(50),
              height: ScreenUtil().setWidth(50),
              fit: BoxFit.fill,
            ),
            Container(
                constraints:
                    BoxConstraints(maxWidth: ScreenUtil().setWidth(180)),
                margin: EdgeInsets.only(
                    left: AppSize.marginSizeMid,
                    right: AppSize.marginSizeMid),
                child: Text(data.shopName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: AppSize.fontSizeMid,
                        color: AppColors.C_333))),
            Expanded(flex: 1, child: Center()),
            Container(
                padding: EdgeInsets.all(AppSize.marginSizeMin),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfffd3374), width: 1),
                    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(2))),
                child: Text('进店看看 >',
                    style: TextStyle(
                        color: Color(0xfffd3374),
                        fontSize: AppSize.fontSize14))),
          ],
        ),
      ),
    );
  }
}
