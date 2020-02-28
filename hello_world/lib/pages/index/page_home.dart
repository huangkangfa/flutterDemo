import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/dao/dao_home.dart';
import 'package:hello_world/model/model_banner_list_entity.dart';
import 'package:hello_world/model/model_item_activity_entity.dart';
import 'package:hello_world/model/model_item_icon_entity.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_gridview.dart';
import 'package:hello_world/widget/base_refresh_list.dart';
import 'package:hello_world/widget/base_toast.dart';
import 'package:hello_world/widget/widget_edit_search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  CancelToken tag = CancelToken();
  int curBannerIndex = 0;
  List<ModelBannerListData> dataBanner = [];
  List<ModelItemIconEntity> dataIcons = [];
  List<ModelItemActivityEntity> dataActivitys = [];

  @override
  void initState() {
    super.initState();
    refreshHomeData();
  }

  refreshHomeData() {
    HomeDao.getHomeBanner({'platform': 0, 'position': 1}, cancelToken: tag)
        .then((data) {
      setState(() {
        dataBanner = data;
      });
    });
    HomeDao.getHomeIcons(cancelToken: tag).then((data) {
      setState(() {
        dataIcons = data;
      });
    });
    HomeDao.getHomeActivitys(cancelToken: tag).then((data) {
      setState(() {
        dataActivitys = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ///通过 StoreConnector 关联 AppState 中的 User
    return StoreConnector<AppState, ModelUserEntity>(
      ///通过 converter 将 AppState 中的 userInfo返回
      converter: (store) => store.state.userInfo,

      ///在 userInfo 中返回实际渲染的控件
      builder: (context, userInfo) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshList(
              TypeOfListView(
                  header: Column(
                children: <Widget>[
                  getSearchBar(),
                  Container(
                    color:
                        dataBanner.length > 0 ? Colors.white : Colors.grey[300],
                    height: ScreenUtil().setWidth(150),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: ThemeSize.marginSizeMin,
                          bottom: ThemeSize.marginSizeMid),
                      child: getADSwiper(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                    child: getIconsBar(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                    child: ComGridView(
                        dataActivitys, buildItemLayoutOfActivitys, 2,
                        padding: ThemeSize.marginSizeMid,
                        mainAxisSpacing: ThemeSize.marginSizeMin,
                        crossAxisSpacing: ThemeSize.marginSizeMin),
                  ),
                ],
              )),
              Apis.products_home, (item, index) {
            return Container(
              height: 80,
              color: index % 2 == 0 ? Colors.red : Colors.blue,
              child: Row(
                children: <Widget>[
                  new Text('哈哈哈哈'),
                ],
              ),
            );
          }),
        );
      },
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

  ///功能那一栏布局渲染
  Widget getIconsBar() {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  ///搜索框布局渲染
  Widget getSearchBar() {
    return comAppbar(
      context,
      left: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: ThemeSize.marginSizeMin),
            child: Icon(Icons.location_on, size: ThemeSize.fontSize22),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: ThemeSize.marginSizeMin,
                bottom: ThemeSize.marginSizeMin),
            child: Text('杭州', style: TextStyle(fontSize: ThemeSize.fontSize14)),
          )
        ],
      ),
      center: EditSearchWidget(),
      right: Padding(
        padding: EdgeInsets.only(
            left: ThemeSize.marginSizeMin, right: ThemeSize.marginSizeMin),
        child: Icon(Icons.shopping_cart, size: ThemeSize.fontSize22),
      ),
    );
  }

  ///轮播图布局渲染
  Widget getADSwiper() {
    if (dataBanner.length <= 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Swiper(
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
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
          child: Image.network(
            dataBanner[index].img,
            fit: BoxFit.fill,
          ),
        );
      },
      itemCount: dataBanner?.length ?? 0,
      viewportFraction: 0.8,
      scale: 0.8,
//      pagination: SwiperPagination(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    HttpManager.getInstance().cancelRequests(tag);
  }

  @override
  bool get wantKeepAlive => true;
}
