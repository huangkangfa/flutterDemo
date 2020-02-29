import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/dao/dao_mall.dart';
import 'package:hello_world/model/model_product_type_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';

class MallView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MallViewState();
  }
}

class MallViewState extends State<MallView> {
  StreamSubscription _streamSubscription;
  CancelToken tag = CancelToken();
  List<ModelProductTypeEntity> dataProductTypes = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    refreshData();
    _streamSubscription = registerEvent<MallViewEvent>((data) {
      if (data is MallViewEvent) {
        switch (data.cmd) {
          case 'refreshData':
            refreshData();
            break;
        }
      }
    });
  }

  refreshData() {
    MallDao.getMallProductType(cancelToken: tag).then((data) {
      setState(() {
        dataProductTypes = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(color: Colors.red, child: Center()),
            ),
            Expanded(
              flex: 2,
              child: Container(color: Colors.blue, child: Center()),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    HttpManager.getInstance().cancelRequests(tag);
  }
}

class MallViewEvent {
  String cmd;

  MallViewEvent(this.cmd);
}

class IndexData{
  String name;
  int id;
  IndexData(this.name,this.id);
}
