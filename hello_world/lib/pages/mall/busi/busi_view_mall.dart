import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_mall.dart';
import 'package:hello_world/model/model_product_type_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_gridview.dart';

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
  ScrollController _controllerOfRight = ScrollController();

  //是否是加载前的界面
  bool isBeforeLoaded = true;

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
      if (this.mounted) {
        setState(() {
          dataProductTypes = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataProductTypes.length == 0) {
      if (isBeforeLoaded) {
        isBeforeLoaded = false;
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      }
      return Align(
        alignment: Alignment.center,
        child: Text('暂无数据~'),
      );
    }
    List<Widget> leftChilds = [];
    List<Widget> rightChilds = [];
    for (int i = 0; i < dataProductTypes.length; i++) {
      leftChilds.add(buildLeftItemLayout(i));
      if (i == selectedIndex) {
        List<ModelProductTypechild> selectedChild =
            dataProductTypes[i].children;
        for (int j = 0; j < selectedChild.length; j++) {
          rightChilds.add(buildRightItemLayout(selectedChild, j));
        }
      }
    }
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
              child: ListView(
            scrollDirection: Axis.vertical,
            children: leftChilds,
          )),
        ),
        Expanded(
          flex: 3,
          child: Container(
              child: ListView(
            controller: _controllerOfRight,
            scrollDirection: Axis.vertical,
            children: rightChilds,
          )),
        ),
      ],
    );
  }

  Padding buildRightItemLayout(
      List<ModelProductTypechild> selectedChild, int j) {
    return Padding(
      padding: EdgeInsets.only(
          left: ThemeSize.marginSizeMid,
          right: ThemeSize.marginSizeMid,
          top: ThemeSize.marginSizeMid),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300], width: 1.0),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8))),
            child: Padding(
              padding: EdgeInsets.all(ThemeSize.marginSizeMid),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(selectedChild[j].name,
                        style: TextStyle(
                            color: ThemeColors.colorFont_333,
                            fontSize: ThemeSize.fontSizeMid)),
                  ),
                  ComGridView(selectedChild[j].children,
                      buildItemLayoutOfRightItemChild, 3,
                      padding: ThemeSize.marginSizeMin,
                      mainAxisSpacing: ThemeSize.marginSizeMin,
                      crossAxisSpacing: ThemeSize.marginSizeMid)
                ],
              ),
            )),
      ),
    );
  }

  Widget buildItemLayoutOfRightItemChild(item, index) {
    ModelProductTypechildchild _item = item as ModelProductTypechildchild;
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: _item.img ??
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583005356676&di=fc5b4f9709aedf34bd4505e5c0df8a1e&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F1e3ead27ad747c7c92e659ac5774587a680bb8d25252-mRVFlu_fw658',
              width: ScreenUtil().setWidth(60),
              height: ScreenUtil().setWidth(60),
              fit: BoxFit.fill),
          Text(
            _item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: ThemeColors.colorFont_333,
                fontSize: ThemeSize.fontSize14),
          )
        ],
      ),
    );
  }

  Widget buildLeftItemLayout(int i) {
    return Container(
      color: i == selectedIndex ? Colors.white : Color(0x00000000),
      height: ScreenUtil().setWidth(40),
      child: GestureDetector(
        onTap: () {
          if (selectedIndex != i) {
            if (this.mounted) {
              setState(() {
                selectedIndex = i;
                _controllerOfRight
                    .jumpTo(_controllerOfRight.position.minScrollExtent);
              });
            }
          }
        },
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Text(
                  dataProductTypes[i].name,
                  style: TextStyle(
                      color: i == selectedIndex
                          ? ThemeColors.colorFont_333
                          : ThemeColors.colorFont_666,
                      fontSize: ThemeSize.fontSizeMid),
                )),
            Visibility(
              visible: i == selectedIndex,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: ScreenUtil().setWidth(40),
                  ),
                  color: ThemeColors.colorPrimary,
                  width: ScreenUtil().setWidth(5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    _controllerOfRight.dispose();
    HttpManager.getInstance().cancelRequests(tag);
  }
}

class MallViewEvent {
  String cmd;

  MallViewEvent(this.cmd);
}

class IndexData {
  String name;
  int id;

  IndexData(this.name, this.id);
}
