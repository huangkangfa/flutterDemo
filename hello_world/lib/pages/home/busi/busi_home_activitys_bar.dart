import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_item_activity_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_gridview.dart';
import 'package:hello_world/widget/base_placeholder.dart';
import 'package:hello_world/widget/base_event_stateful.dart';
import 'package:hello_world/widget/base_dialog.dart';

class HomeActivitysBar extends StatefulWidget {
  HomeActivitysBar({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new HomeActivitysBarState();
  }
}

class HomeActivitysBarState extends EventStateful<HomeActivitysBar,HomeActivitysBarEvent> {
  CancelToken tag = CancelToken();
  List<ModelItemActivityEntity> dataActivitys = [];

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  void doThingsForEvent(HomeActivitysBarEvent data) {
    switch (data.cmd) {
      case 'refreshData':
        refreshData();
        break;
    }
  }

  refreshData() {
    HomeDao.getHomeActivitys(cancelToken: tag).then((data) {
      if (this.mounted) {
        setState(() {
          dataActivitys = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataActivitys.length == 0) {
      return PlaceHolderView(
          ScreenUtil().setWidth(ScreenUtil.screenWidthDp) -
              AppSize.marginSizeMin * 2,
          ScreenUtil().setWidth(160));
    }
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
      child: ComGridView(dataActivitys, buildItemLayoutOfActivitys, 2,
          padding: AppSize.marginSizeMid,
          mainAxisSpacing: AppSize.marginSizeMin,
          crossAxisSpacing: AppSize.marginSizeMin),
    );
  }

  onClick(index) {
    showToast('点击了' + index.toString());
  }

  ///活动子项布局渲染
  Widget buildItemLayoutOfActivitys(result, index) {
    ModelItemActivityEntity item = result as ModelItemActivityEntity;
    Color colorBg = index % 4 < 2 ? Color(0xffFFF4F7) : Color(0xfffff4eb);
    Color colorTv1 = index % 4 < 2 ? Color(0xffFC4D79) : Color(0xffFF703D);
    Color colorTv2 = index % 4 < 2 ? Color(0xffFB5B86) : Color(0xffFF9973);
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () => onClick(index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
            child: Container(
              decoration: BoxDecoration(
                  color: colorBg,
                  border: Border.all(color: Colors.grey[200], width: 1.0),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(5))),
              child: Padding(
                padding: EdgeInsets.all(AppSize.marginSize12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: ScreenUtil().setWidth(100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: colorTv1,
                                  fontSize: ScreenUtil().setSp(15))),
                          Text(item.subName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: colorTv2,
                                  fontSize: ScreenUtil().setSp(12))),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(),
                    ),
                    CachedNetworkImage(
                      imageUrl: item.img,
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setWidth(50),
                      fit: BoxFit.fill,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    HttpManager.getInstance().cancelRequests(tag);
  }

}

class HomeActivitysBarEvent {
  String cmd;

  HomeActivitysBarEvent(this.cmd);
}
