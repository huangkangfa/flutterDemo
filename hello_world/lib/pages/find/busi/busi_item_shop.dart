import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/model/model_item_find_shop_entity.dart';
import 'package:hello_world/util/util_screen.dart';

class ItemOfList extends StatelessWidget {
  final ModelItemFindShopEntity shopEntity;
  final int index;
  final Function callback;

  ItemOfList(this.shopEntity, this.index, {Key key, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.callback != null) {
          this.callback();
        }
      },
      child:Padding(
        padding: EdgeInsets.all(AppSize.marginSizeMid),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: ClipOval(
                    child: CachedNetworkImage(
                        imageUrl: shopEntity.logo,
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setWidth(50),
                        fit: BoxFit.fill)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: AppSize.marginSizeMid),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(180),
                      child: Text(shopEntity.shop,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.C_333,
                              fontSize: AppSize.fontSizeMid,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(Icons.location_on,
                              size: AppSize.fontSizeMid,
                              color: AppColors.C_999),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(180),
                          child: Text(
                            shopEntity.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.C_999,
                                fontSize: AppSize.fontSize14),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(shopEntity.distance.toString() + shopEntity.unit,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.C_666,
                        fontSize: AppSize.fontSize14)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
