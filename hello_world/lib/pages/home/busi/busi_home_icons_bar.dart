import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_item_icon_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_event_stateful.dart';
import 'package:hello_world/widget/base_placeholder.dart';
import 'package:hello_world/widget/base_dialog.dart';

class HomeIconsBar extends StatefulWidget {
  HomeIconsBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeIconsBarState();
  }
}

class HomeIconsBarState extends EventStateful<HomeIconsBar, HomeIconsBarEvent> {
  CancelToken tag = CancelToken();
  List<ModelItemIconEntity> dataIcons = [];

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  void doThingsForEvent(HomeIconsBarEvent data) {
    switch (data.cmd) {
      case 'refreshData':
        refreshData();
        break;
    }
  }

  refreshData() {
    HomeDao.getHomeIcons(cancelToken: tag).then((data) {
      if (this.mounted) {
        setState(() {
          dataIcons = data;
        });
      }
    });
  }

  onClick(index) {
    showToast('点击了' + index.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (dataIcons.length == 0) {
      return PlaceHolderView(
          ScreenUtil().setWidth(ScreenUtil.screenWidthDp) -
              AppSize.marginSizeMin * 2,
          ScreenUtil().setWidth(70));
    }
    List<Widget> children = [];
    for (int i = 0; i < dataIcons.length; i++) {
      children.add(Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => onClick(i),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: dataIcons[i].img,
                  width: ScreenUtil().setWidth(42),
                  height: ScreenUtil().setWidth(42),
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.only(top: AppSize.marginSizeMin),
                  child: Text(dataIcons[i].name),
                ),
              ],
            ),
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
    HttpManager.getInstance().cancelRequests(tag);
  }
}

class HomeIconsBarEvent {
  String cmd;

  HomeIconsBarEvent(this.cmd);
}
