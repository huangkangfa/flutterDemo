import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/pages/index/home/busi/busi_home_activitys_bar.dart';
import 'package:hello_world/pages/index/home/busi/busi_home_icons_bar.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_refresh_sliver_list.dart';

import 'busi/busi_home_banner.dart';
import 'busi/busi_home_list_item_product.dart';
import 'busi/busi_search_bar.dart';
import 'busi/busi_shopbar.dart';

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
  }

  refreshHomeData() {
    sendEvent(HomeBannerEvent('refreshData'));
    sendEvent(HomeIconsBarEvent('refreshData'));
    sendEvent(HomeActivitysBarEvent('refreshData'));
    sendEvent(ShopBarEvent('refreshData'));
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
          body: RefreshSliverList(
              TypeOfSliverGridView(2,
                  mainAxisSpacing: ScreenUtil().setWidth(10),
                  childAspectRatio: 0.7,
                  crossAxisSpacing: ThemeSize.marginSizeMin,
                  paddingLeft: ThemeSize.marginSizeMid,
                  paddingRight: ThemeSize.marginSizeMid),
              Apis.products_home, (item, index) {
            return ListItemOfProduct(ModelItemProductEntity().fromJson(item));
          }, sliverHeader: [
            SliverToBoxAdapter(child: HomeBanner()),
            SliverToBoxAdapter(child: HomeIconsBar()),
            SliverToBoxAdapter(child: HomeActivitysBar()),
            SliverToBoxAdapter(child: HomeSmallTitle('健康聚集地')),
            SliverToBoxAdapter(child: ShopBar()),
            SliverToBoxAdapter(child: HomeSmallTitle('热门推荐'))
          ]),
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
