import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/pages/index/home/busi/busi_home_activitys_bar.dart';
import 'package:hello_world/pages/index/home/busi/busi_home_icons_bar.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/widget/base_refresh_list.dart';

import 'busi/busi_home_banner.dart';
import 'busi/busi_search_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  void initState() {
    super.initState();
    refreshHomeData();
  }

  refreshHomeData() {
    sendEvent(HomeBannerEvent('refreshData'));
    sendEvent(HomeIconsBarEvent('refreshData'));
    sendEvent(HomeActivitysBarEvent('refreshData'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StoreConnector<AppState, ModelUserEntity>(
      converter: (store) => store.state.userInfo,
      builder: (context, userInfo) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: getListBody(),
        );
      },
    );
  }

  Widget getListHeader() {
    return Column(
      children: <Widget>[
        SearchBar(),
        HomeBanner(),
        HomeIconsBar(),
        HomeActivitysBar(),
      ],
    );
  }

  Widget getListBody() {
    return RefreshList(
        TypeOfListView(header: getListHeader()), Apis.products_home,
        (item, index) {
      return Container(
        height: 80,
        color: index % 2 == 0 ? Colors.red : Colors.blue,
        child: Row(
          children: <Widget>[
            new Text('哈哈哈哈'),
          ],
        ),
      );
    }, onRefresh: () {
      refreshHomeData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
