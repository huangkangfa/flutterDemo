import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_item_icon_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';

class HomeIconsBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeIconsBarState();
  }
}

class HomeIconsBarState extends State<HomeIconsBar> {
  StreamSubscription _streamSubscription;
  CancelToken tag = CancelToken();
  List<ModelItemIconEntity> dataIcons = [];

  @override
  void initState() {
    super.initState();
    refreshData();
    _streamSubscription = registerEvent<HomeIconsBarEvent>((data) {
      if (data is HomeIconsBarEvent) {
        switch (data.cmd) {
          case 'refreshData':
            refreshData();
            break;
        }
      }
    });
  }

  refreshData() {
    HomeDao.getHomeIcons(cancelToken: tag).then((data) {
      setState(() {
        dataIcons = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < dataIcons.length; i++) {
      children.add(Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                dataIcons[i].img,
                width: ScreenUtil().setWidth(42),
                height: ScreenUtil().setWidth(42),
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(top: ThemeSize.marginSizeMin),
                child: Text(dataIcons[i].name),
              ),
            ],
          )));
    }
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
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

class HomeIconsBarEvent {
  String cmd;

  HomeIconsBarEvent(this.cmd);
}
