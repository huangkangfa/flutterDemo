import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_item_find_shop_entity.dart';
import 'package:hello_world/pages/home/busi/busi_search_bar.dart';
import 'package:hello_world/pages/mine/busi/busi_mine_button_top.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_refresh_sliver_list.dart';
import 'package:hello_world/widget/base_toast.dart';

import 'busi/busi_find_banner.dart';
import 'busi/busi_find_index_gridview.dart';

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
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[
            RefreshSliverList(
                TypeOfSliverFixedExtentListView(ScreenUtil().setWidth(80)),
                Apis.selectServerMchInfoPaging,
                (item, index) => buildItemLayout(item, index),
                sliverHeader: <Widget>[
                  SliverToBoxAdapter(child: FindIndexGridView()),
                  SliverToBoxAdapter(child: FindBanner()),
                ],
                scrollPhysics: BouncingScrollPhysics(),
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
    ModelItemFindShopEntity shopEntity = ModelItemFindShopEntity().fromJson(item);
    print('############################################### 构建 $index 子项');
    return ItemOfList(shopEntity,index, callback: () => onClick(index));
  }

  @override
  bool get wantKeepAlive => true;
}

class ItemOfList extends StatelessWidget {
  final ModelItemFindShopEntity shopEntity;
  final int index;
  final Function callback;

  ItemOfList(this.shopEntity,this.index, {Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('############################################### 重新构建 $index 子项');
    return GestureDetector(
      onTap: () {
        if (this.callback != null) {
          this.callback();
        }
      },
      child: Padding(
        padding: EdgeInsets.all(ThemeSize.marginSizeMid),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: ClipOval(
                    child: CachedNetworkImage(
                        imageUrl: shopEntity.logo,
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setWidth(50),
                        fit: BoxFit.fill)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: ThemeSize.marginSizeMid),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(180),
                      child: Text(shopEntity.shop,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ThemeColors.colorFont_333,
                              fontSize: ThemeSize.fontSizeMid,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(Icons.location_on,
                              size: ThemeSize.fontSizeMid,
                              color: ThemeColors.colorFont_999),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(180),
                          child: Text(
                            shopEntity.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ThemeColors.colorFont_999,
                                fontSize: ThemeSize.fontSize14),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(shopEntity.distance.toString() + shopEntity.unit,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ThemeColors.colorFont_666,
                        fontSize: ThemeSize.fontSize14)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
