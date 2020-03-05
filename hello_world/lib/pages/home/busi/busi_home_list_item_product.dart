import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/util/util_screen.dart';

class ListItemOfProduct extends StatelessWidget {
  final ModelItemProductEntity product;
  final Function onTap;

  ListItemOfProduct(this.product, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: ClipRRect(
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
                  child: CachedNetworkImage(
                    imageUrl: product.images,
                    fit: BoxFit.fill,
                  )),
              Container(
                height: ScreenUtil().setWidth(45),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: AppSize.marginSizeMid,
                        right: AppSize.marginSizeMid),
                    child: Padding(
                      padding: EdgeInsets.only(top: AppSize.marginSizeMin),
                      child: Stack(
                        children: <Widget>[
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
                                  text: product.name,
                                  style: TextStyle(
                                      fontSize: AppSize.fontSize14,
                                      color: AppColors.C_333)),
                            ]),
                          ),
                          ShopFlag()
                        ],
                      ),
                    ),
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
                          left: AppSize.marginSizeMid,
                          right: AppSize.marginSizeMid),
                      child: Text('￥${product.price / 100}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xffff4d7a),
                              fontSize: AppSize.fontSize14)),
                    ),
                    Expanded(flex: 1, child: Center()),
                    Padding(
                      padding: EdgeInsets.only(right: AppSize.marginSizeMid),
                      child: product.isVipPrice == 1
                          ? MemberPriceFlag(
                              price: product.minVipPrice?.toDouble())
                          : Center(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MemberPriceFlag extends StatelessWidget {
  final double price;

  MemberPriceFlag({this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE5CDA2), width: 1),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(3))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Color(0xffE5CDA2),
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(2),
                right: ScreenUtil().setWidth(2),
              ),
              child: Text(
                '会员',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(10)),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(2),
                right: ScreenUtil().setWidth(2),
              ),
              child: Text(
                '￥${price == null ? 0 : price / 100}',
                style: TextStyle(
                    color: Color(0xffE5CDA2), fontSize: ScreenUtil().setSp(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShopFlag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(4)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xff9CD3CF), width: 0.5),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(2))),
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(2),
            right: ScreenUtil().setWidth(2),
          ),
          child: Text('自营',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(9), color: Color(0xff9CD3CF))),
        ),
      ),
    );
  }
}
