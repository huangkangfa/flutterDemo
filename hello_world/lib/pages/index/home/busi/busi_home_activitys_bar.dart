import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_item_activity_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_gridview.dart';

class HomeActivitysBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeActivitysBarState();
  }
}

class HomeActivitysBarState extends State<HomeActivitysBar> {
  StreamSubscription _streamSubscription;
  CancelToken tag = CancelToken();
  List<ModelItemActivityEntity> dataActivitys = [];

  @override
  void initState() {
    super.initState();
    _streamSubscription = registerEvent<HomeActivitysBarEvent>((data) {
      if (data is HomeActivitysBarEvent) {
        switch(data.cmd){
          case 'refreshData':
            refreshData();
            break;
        }
      }
    });
    refreshData();
  }

  refreshData(){
    HomeDao.getHomeActivitys(cancelToken: tag).then((data) {
      setState(() {
        dataActivitys = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
      child: ComGridView(dataActivitys, buildItemLayoutOfActivitys, 2,
          padding: ThemeSize.marginSizeMid,
          mainAxisSpacing: ThemeSize.marginSizeMin,
          crossAxisSpacing: ThemeSize.marginSizeMin),
    );
  }

  ///活动子项布局渲染
  Widget buildItemLayoutOfActivitys(index) {
    Color color = index % 4 < 2 ? Color(0xfffef6f4) : Color(0xfffff4eb);
    return Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
          child: Container(
            color: color,
            child: Padding(
              padding: EdgeInsets.all(ThemeSize.marginSize12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(dataActivitys[index].name),
                      Text(dataActivitys[index].subName),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(),
                  ),
                  Image.network(
                    dataActivitys[index].img,
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setWidth(50),
                    fit: BoxFit.fill,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    HttpManager.getInstance().cancelRequests(tag);
  }

}

class HomeActivitysBarEvent {
  String cmd;

  HomeActivitysBarEvent(this.cmd);
}