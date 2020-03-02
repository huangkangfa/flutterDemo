import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/pages/mine/busi/busi_mine_button_top.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_refresh_sliver_list.dart';

import 'busi/busi_home_activitys_bar.dart';
import 'busi/busi_home_banner.dart';
import 'busi/busi_home_icons_bar.dart';
import 'busi/busi_home_list_item_product.dart';
import 'busi/busi_search_bar.dart';
import 'busi/busi_shopbar.dart';
import 'busi/busi_type_selector.dart';

class HomePage extends StatefulWidget {
  static const pageTag = 'home';

  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  bool showTop = false;

  @override
  void initState() {
    super.initState();
  }

  refreshHomeData() {
    sendEvent(HomeBannerEvent('refreshData'));
    sendEvent(HomeIconsBarEvent('refreshData'));
    sendEvent(HomeActivitysBarEvent('refreshData'));
    sendEvent(ShopBarEvent('refreshData'));
  }

  controlTopVisibility(notification) {
    if (notification is ScrollNotification) {
      ScrollMetrics metrics = notification.metrics;
      bool result = metrics.extentBefore > ScreenUtil().setWidth(300);
      if (result != showTop && metrics.axis == Axis.vertical) {
        if (this.mounted) {
          setState(() {
            showTop = result;
            sendEvent(ButtonOfTopEvent('home', 'changeFlag', flag: showTop));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, ModelUserEntity>(
      converter: (store) => store.state.userInfo,
      builder: (context, userInfo) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: comAppbar(context, appBar: SearchBar()),
          body: Stack(
            children: <Widget>[
              RefreshSliverList(
                  TypeOfSliverGridView(2,
                      mainAxisSpacing: ScreenUtil().setWidth(10),
                      childAspectRatio: 0.7,
                      crossAxisSpacing: ThemeSize.marginSizeMin,
                      paddingLeft: ThemeSize.marginSizeMid,
                      paddingRight: ThemeSize.marginSizeMid),
                  Apis.products_home,
                  (item, index) {
                    ModelItemProductEntity obj =
                        ModelItemProductEntity().fromJson(item);
                    return ListItemOfProduct(obj, key: ValueKey(obj.id));
                  },
                  tag: HomePage.pageTag,
                  onRefresh: () {
                    refreshHomeData();
                  },
                  scrollPhysics: BouncingScrollPhysics(),
                  sliverHeader: [
                    SliverToBoxAdapter(child: HomeBanner()),
                    SliverToBoxAdapter(child: HomeIconsBar()),
                    SliverToBoxAdapter(child: HomeActivitysBar()),
                    SliverToBoxAdapter(child: HomeHealthTitle()),
                    SliverToBoxAdapter(child: ShopBar()),
                    SliverToBoxAdapter(child: HomeSmallTitle('热门推荐'))
                  ],
                  onNotification: (notification) {
                    controlTopVisibility(notification);
                  }),
              ButtonOfTop(HomePage.pageTag)
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeHealthTitle extends StatelessWidget {
  HomeHealthTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        HomeSmallTitle('健康聚集地'),

        ///以下内容放开会存在一个闪屏bug，就是选项处于好评时且列表处于置顶状态，点击空白处会闪屏
        Expanded(flex: 1, child: Center()),
        Padding(
          padding: EdgeInsets.only(right: ThemeSize.marginSizeMid),
          child: TypeSelector(HomePage.pageTag, onTap: (index) {
            sendEvent(ShopBarEvent('refreshData', isDistanceType: index == 1));
          }),
        )
      ],
    );
  }
}

class HomeSmallTitle extends StatelessWidget {
  final String title;

  HomeSmallTitle(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeSize.marginSizeMid),
      child: Text(title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(18),
              color: ThemeColors.colorFont_333)),
    );
  }
}
