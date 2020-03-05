import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/pages/home/busi/busi_home_list_item_product.dart';

class ProductDetailTitle extends StatelessWidget {
  final ModelProductEntity data;

  ProductDetailTitle(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null) return Center();
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: AppSize.marginSizeMid),
      child: Padding(
        padding: EdgeInsets.all(AppSize.marginSizeMid),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('￥${data.minPrice / 100}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xffff4d7a),
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.fontSizeMax)),
                Visibility(
                    visible: data.isVipPrice == 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppSize.marginSizeMin),
                      child: MemberPriceFlag(
                          price: data.minVipPrice?.toDouble() ?? 0),
                    )),
                Expanded(flex: 1, child: Center()),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: AppSize.marginSizeMid,bottom: AppSize.marginSizeMid),
                child: Stack(
                  children: [
                    RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: '自营 ',
                              style: TextStyle(
                                  fontSize: AppSize.fontSizeMin,
                                  color: Color(0x009CD3CF))),
                          TextSpan(
                              text: data.productName,
                              style: TextStyle(
                                  fontSize: AppSize.fontSizeMid,
                                  color: AppColors.C_333)),
                        ])),
                    ShopFlag()
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Text(data.cityName,
                    style: TextStyle(
                        fontSize: AppSize.fontSizeMin,
                        color: AppColors.C_333)),
                Expanded(flex: 1, child: Center()),
                Text('已销售：${data.soldAmount.toString()}',
                    style: TextStyle(
                        fontSize: AppSize.fontSizeMin,
                        color: AppColors.C_333)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
