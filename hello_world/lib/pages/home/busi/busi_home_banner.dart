import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_banner_list_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_placeholder.dart';
import 'package:hello_world/widget/base_toast.dart';

class HomeBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeBannerState();
  }
}

class HomeBannerState extends State<HomeBanner> {
  CancelToken tag = CancelToken();
  StreamSubscription _streamSubscription;
  List<ModelBannerListData> dataBanner = [];
  int curBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    refreshData();
    _streamSubscription = registerEvent<HomeBannerEvent>((data) {
      if (data is HomeBannerEvent) {
        switch (data.cmd) {
          case 'refreshData':
            refreshData();
            break;
        }
      }
    });
  }

  refreshData() {
    HomeDao.getHomeBanner({'platform': 0, 'position': 1}, cancelToken: tag)
        .then((data) {
      if (this.mounted) {
        setState(() {
          dataBanner = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataBanner.length == 0) {
      return PlaceHolderView(
          ScreenUtil().setWidth(ScreenUtil.screenWidthDp) -
              ThemeSize.marginSizeMin * 2,
          ScreenUtil().setWidth(140));
    }
    return Container(
      color: dataBanner.length > 0 ? Colors.white : Colors.grey[300],
      height: ScreenUtil().setWidth(150),
      child: Padding(
        padding: EdgeInsets.only(
            top: ThemeSize.marginSizeMin, bottom: ThemeSize.marginSizeMid),
        child: Swiper(
          autoplay: true,
          index: curBannerIndex,
          onIndexChanged: (index) {
            curBannerIndex = index;
          },
          onTap: (index) {
            showToast('index = ' + index.toString());
          },
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(ThemeSize.marginSizeMin),
              child: CachedNetworkImage(
                imageUrl: dataBanner[index].img,
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: dataBanner.length,
          viewportFraction: 0.8,
          scale: 0.8,
//      pagination: SwiperPagination(),
        ),
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

class HomeBannerEvent {
  String cmd;

  HomeBannerEvent(this.cmd);
}
