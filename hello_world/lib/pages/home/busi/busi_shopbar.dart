import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_item_shop_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_event_stateful.dart';
import 'package:hello_world/widget/base_placeholder.dart';
import 'package:hello_world/widget/base_toast.dart';

class ShopBar extends StatefulWidget {
  ShopBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShopBarState();
  }
}

class ShopBarState extends EventStateful<ShopBar, ShopBarEvent> {
  CancelToken tag = CancelToken();
  List<ModelItemShopEntity> dataShops = [];
  ScrollController controller = ScrollController();
  bool isDistanceType = true;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  refreshData() {
    HomeDao.getHomeShops(
            {'lat': 30.289374, 'lng': 120.036316, 'cityCode': 330100},
            cancelToken: tag, isDistance: isDistanceType)
        .then((data) {
      if (this.mounted) {
        setState(() {
          if (controller.hasClients) {
            controller.jumpTo(controller.position.minScrollExtent);
          }
          dataShops = data;
        });
      }
    });
  }

  onClick(index) {
    showToast('点击了' + index.toString());
  }

  onMoreClick() {
    showToast('点击了更多');
  }

  @override
  Widget build(BuildContext context) {
    if (dataShops.length == 0) {
      return PlaceHolderView(
          ScreenUtil().setWidth(ScreenUtil.screenWidthDp) -
              AppSize.marginSizeMin * 2,
          ScreenUtil().setWidth(130));
    }
    List<Widget> childs = [];
    for (int i = 0; i < dataShops.length; i++) {
      childs.add(Padding(
        padding: EdgeInsets.only(
            left: AppSize.marginSizeMid,
            top: AppSize.marginSizeMid,
            bottom: AppSize.marginSizeMid),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
          child: GestureDetector(
            onTap: () => onClick(i),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200], width: 1.0),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(5))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: dataShops[i].advertisingImg,
                    width: ScreenUtil().setWidth(154),
                    height: ScreenUtil().setWidth(100),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: ScreenUtil().setWidth(154),
                      minWidth: ScreenUtil().setWidth(154),
                    ),
                    height: ScreenUtil().setWidth(30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: AppSize.marginSizeMin,
                            right: AppSize.marginSizeMin),
                        child: Text(
                          dataShops[i].shop,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.fontSize14,
                              color: AppColors.C_333),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    }

    childs.add(Padding(
      padding: EdgeInsets.all(AppSize.marginSizeMid),
      child: GestureDetector(
        onTap: () => onMoreClick(),
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(AppSize.marginSizeMax),
            child: Center(
              child: Text(
                '更\n多',
                style: TextStyle(
                    color: Colors.white, fontSize: AppSize.fontSizeMid),
              ),
            ),
          ),
        ),
      ),
    ));

    return Container(
      height: ScreenUtil().setWidth(150),
      child: ListView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: childs,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    HttpManager.getInstance().cancelRequests(tag);
  }

  @override
  void doThingsForEvent(ShopBarEvent data) {
    switch (data.cmd) {
      case 'refreshData':
        isDistanceType = data.isDistanceType ?? true;
        refreshData();
        break;
    }
  }
}

class ShopBarEvent {
  String cmd;
  bool isDistanceType;

  ShopBarEvent(this.cmd, {this.isDistanceType});
}
