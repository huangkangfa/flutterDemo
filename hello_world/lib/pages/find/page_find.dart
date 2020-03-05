import 'package:flutter/material.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/index.dart';
import 'package:hello_world/model/model_item_find_shop_entity.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/pages/home/busi/busi_search_bar.dart';
import 'package:hello_world/pages/mine/busi/busi_mine_button_top.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_refresh_sliver_list.dart';
import 'package:hello_world/widget/base_toast.dart';

import 'busi/busi_find_banner.dart';
import 'busi/busi_find_index_gridview.dart';
import 'busi/busi_item_shop.dart';

class FindPage extends StatefulWidget {
  static final String pageTag = 'find';

  FindPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FindPageState();
  }
}

class FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin<FindPage> {
  bool showTop = false;

  controlTopVisibility(notification) {
    if (notification is ScrollNotification) {
      ScrollMetrics metrics = notification.metrics;
      bool result = metrics.extentBefore > ScreenUtil().setWidth(300);
      if (result != showTop && metrics.axis == Axis.vertical) {
        if (this.mounted) {
          setState(() {
            showTop = result;
            sendEvent(ButtonOfTopEvent(FindPage.pageTag, 'changeFlag',
                flag: showTop));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: comAppbar(context, appBar: SearchBar()),
      body: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[
            RefreshSliverList(
                TypeOfSliverFixedExtentListView(ScreenUtil().setWidth(80)),
//                Apis.selectServerMchInfoPaging,
                Apis.products_home,
                (item, index) => buildItemLayout(item, index),
                sliverHeader: <Widget>[
                  SliverToBoxAdapter(child: FindIndexGridView()),
                  SliverToBoxAdapter(child: FindBanner()),
                ],
                params: {
                  'lat': 30.289374,
                  'lng': 120.036316,
                  'cityCode': 330100
                },
                tag: FindPage.pageTag, onNotification: (notification) {
              controlTopVisibility(notification);
            }),
            ButtonOfTop(FindPage.pageTag)
          ],
        ),
      ),
    );
  }

  onClick(index) {
    showToast('点击了' + index.toString());
  }

  buildItemLayout(item, index) {
    ModelItemFindShopEntity shopEntity = ModelItemFindShopEntity();
    ModelItemProductEntity obj = ModelItemProductEntity().fromJson(item);
    shopEntity.id = obj.id;
    shopEntity.logo = obj.images;
    shopEntity.shop = obj.name;
    shopEntity.address = obj.name;
    shopEntity.distance = 100;
    shopEntity.unit = 'm';
//    ModelItemFindShopEntity shopEntity = ModelItemFindShopEntity().fromJson(item);
    return ItemOfList(shopEntity,index, callback: () => onClick(index),key: ValueKey(shopEntity.id));
  }

  @override
  bool get wantKeepAlive => true;
}


