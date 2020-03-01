import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_find.dart';
import 'package:hello_world/model/model_find_index_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_gridview.dart';
import 'package:hello_world/widget/base_placeholder.dart';
import 'package:hello_world/widget/base_toast.dart';
import 'package:hello_world/widget/widget_swiper_pagination.dart';

class FindIndexGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FindIndexGridViewState();
  }
}

class FindIndexGridViewState extends State<FindIndexGridView> {
  StreamSubscription _streamSubscription;
  CancelToken tag = CancelToken();
  List<ModelFindIndexEntity> dataIndexs = [];
  List<IndexItem> dataPage = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    refreshData();
    _streamSubscription = registerEvent<FindIndexGridViewEvent>((data) {
      if (data is FindIndexGridViewEvent) {
        switch (data.cmd) {
          case 'refreshData':
            refreshData();
            break;
        }
      }
    });
  }

  refreshData() {
    FindDao.getFindIndexs(cancelToken: tag).then((data) {
      if (this.mounted) {
        setState(() {
          dataIndexs = data;
          setPageData(data);
          print(dataIndexs.toString());
          print(dataPage.toString());
        });
      }
    });
  }

  setPageData(List<ModelFindIndexEntity> data) {
    dataPage.clear();
    int pageNum = (data.length / 8).ceil().toInt();
    for (int i = 0; i < pageNum; i++) {
      List<ModelFindIndexEntity> childs = [];
      int start = i * 8;
      int end = (i + 1) * 8 < data.length ? (i + 1) * 8 : data.length;
      for (int j = start; j < end; j++) {
        childs.add(data[j]);
      }
      dataPage.add(IndexItem(i, childs));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataIndexs.length == 0 || dataPage.length == 0) {
      return PlaceHolderView(
          ScreenUtil().setWidth(ScreenUtil.screenWidthDp) -
              ThemeSize.marginSizeMin * 2,
          ScreenUtil().setWidth(140));
    }
    return Container(
      height: ScreenUtil().setWidth(165),
      child: Swiper(
        autoplay: false,
        index: selectedIndex,
        onIndexChanged: (index) {
          selectedIndex = index;
        },
        itemBuilder: (BuildContext context, int index) =>
            buildItemLayout(context, index),
        itemCount: dataPage.length,
        viewportFraction: 1,
        scale: 1,
        pagination: buildCustomPagination(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    HttpManager.getInstance().cancelRequests(tag);
  }

  buildCustomPagination() {
    return SwiperCustomPagination(
        builder: (BuildContext context, SwiperPluginConfig config) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: PageIndicator(
          layout: PageIndicatorLayout.SCALE,
          size: ScreenUtil().setWidth(8),
          space: ThemeSize.marginSizeMin,
          count: config.itemCount,
          controller: config.pageController,
          color: ThemeColors.colorPrimary,
          activeColor: ThemeColors.colorFont_333,
        ),
      );
    });
  }

  buildItemLayout(BuildContext context, int index) {
    return ComGridView(dataPage[index].childs, buildItemChildLayout, 4,
        paddingTop: ScreenUtil().setWidth(30),
        mainAxisSpacing: ThemeSize.marginSizeMid,
        crossAxisSpacing: ThemeSize.marginSizeMax);
  }

  buildItemChildLayout(ModelFindIndexEntity item, index) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          showToast(item.name);
        },
        child: Center(
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                  imageUrl: item.img,
                  fit: BoxFit.fill,
                  width: ScreenUtil().setWidth(30),
                  height: ScreenUtil().setWidth(30)),
              Text(item.name)
            ],
          ),
        ),
      ),
    );
  }
}

class FindIndexGridViewEvent {
  String cmd;

  FindIndexGridViewEvent(this.cmd);
}

class IndexItem {
  int index;
  List<ModelFindIndexEntity> childs;

  IndexItem(this.index, this.childs);
}
