import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
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
                        left: ThemeSize.marginSizeMid,
                        right: ThemeSize.marginSizeMid),
                    child: Padding(
                      padding: EdgeInsets.only(top: ThemeSize.marginSizeMin),
                      child: Stack(
                        children: <Widget>[
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: '自营 ',
                                  style: TextStyle(
                                      fontSize: ThemeSize.fontSizeMin,
                                      color: Color(0x009CD3CF))),
                              TextSpan(
                                  text: product.name,
                                  style: TextStyle(
                                      fontSize: ThemeSize.fontSize14,
                                      color: ThemeColors.colorFont_333)),
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
                          left: ThemeSize.marginSizeMid,
                          right: ThemeSize.marginSizeMid),
                      child: Text('￥${product.price / 100}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xffff4d7a),
                              fontSize: ThemeSize.fontSize14)),
                    ),
                    Expanded(flex: 1, child: Center()),
                    Padding(
                      padding: EdgeInsets.only(right: ThemeSize.marginSizeMid),
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
