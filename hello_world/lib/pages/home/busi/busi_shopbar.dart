import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_item_shop_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_placeholder.dart';

class ShopBar extends StatefulWidget {
  ShopBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShopBarState();
  }
}

class ShopBarState extends State<ShopBar> {
  StreamSubscription _streamSubscription;
  CancelToken tag = CancelToken();
  List<ModelItemShopEntity> dataShops = [];
  ScrollController controller = ScrollController();
  bool isDistanceType = true;

  @override
  void initState() {
    super.initState();
    refreshData();
    _streamSubscription = registerEvent<ShopBarEvent>((data) {
      if (data is ShopBarEvent) {
        switch (data.cmd) {
          case 'refreshData':
            isDistanceType = data.isDistanceType ?? true;
            refreshData();
            break;
        }
      }
    });
  }

  refreshData() {
    HomeDao.getHomeShops(
            {'lat': 30.289374, 'lng': 120.036316, 'cityCode': 330100},
            cancelToken: tag, isDistance: isDistanceType)
        .then((data) {
      if (this.mounted) {
        setState(() {
//          if(controller.hasClients){
//            controller.jumpTo(controller.position.minScrollExtent);
//          }
          dataShops = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataShops.length == 0) {
      return PlaceHolderView(
          ScreenUtil().setWidth(ScreenUtil.screenWidthDp) -
              ThemeSize.marginSizeMin * 2,
          ScreenUtil().setWidth(130));
    }
    List<Widget> childs = [];
    for (int i = 0; i < dataShops.length; i++) {
      childs.add(Padding(
        padding: EdgeInsets.only(
            left: ThemeSize.marginSizeMid,
            top: ThemeSize.marginSizeMid,
            bottom: ThemeSize.marginSizeMid),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[200], width: 1.0),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  dataShops[i].advertisingImg,
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
                          left: ThemeSize.marginSizeMin,
                          right: ThemeSize.marginSizeMin),
                      child: Text(
                        dataShops[i].shop,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ThemeSize.fontSize14,
                            color: ThemeColors.colorFont_333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    childs.add(Padding(
      padding: EdgeInsets.all(ThemeSize.marginSizeMid),
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(ThemeSize.marginSizeMax),
          child: Center(
            child: Text(
              '更\n多',
              style: TextStyle(
                  color: Colors.white, fontSize: ThemeSize.fontSizeMid),
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
    _streamSubscription.cancel();
    controller.dispose();
    HttpManager.getInstance().cancelRequests(tag);
  }
}

class ShopBarEvent {
  String cmd;
  bool isDistanceType;

  ShopBarEvent(this.cmd, {this.isDistanceType});
}