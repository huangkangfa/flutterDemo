import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_item_shop_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';

class ShopBar extends StatefulWidget {
  ShopBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ShopBarState();
  }
}

class ShopBarState extends State<ShopBar> {
  StreamSubscription _streamSubscription;
  CancelToken tag = CancelToken();
  List<ModelItemShopEntity> dataShops = [];

  @override
  void initState() {
    super.initState();
    refreshData();
    _streamSubscription = registerEvent<ShopBarEvent>((data) {
      if (data is ShopBarEvent) {
        switch (data.cmd) {
          case 'refreshData':
            refreshData();
            break;
        }
      }
    });
  }

  refreshData() {
    HomeDao.getHomeShops(
            {'lat': 30.289374, 'lng': 120.036316, 'cityCode': 330100},
            cancelToken: tag)
        .then((data) {
      setState(() {
        dataShops = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            color: Colors.white,
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
      height: ScreenUtil().setWidth(146),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: childs,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    HttpManager.getInstance().cancelRequests(tag);
  }
}

class ShopBarEvent {
  String cmd;

  ShopBarEvent(this.cmd);
}
