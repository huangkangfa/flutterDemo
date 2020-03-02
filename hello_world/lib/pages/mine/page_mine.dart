import 'package:flutter/material.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/pages/home/busi/busi_home_list_item_product.dart';
import 'package:hello_world/pages/home/page_home.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_refresh_sliver_list.dart';

import 'busi/busi_mine_button_top.dart';
import 'busi/busi_mine_card1.dart';
import 'busi/busi_mine_card2.dart';
import 'busi/busi_mine_card3.dart';
import 'busi/busi_mine_sliver_appbar.dart';

class MinePage extends StatefulWidget {
  static const pageTag = 'mine';

  MinePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin<MinePage> {
  bool showHeadimg = false;

  controlHeadImg(notification) {
    if (notification is ScrollNotification) {
      ScrollMetrics metrics = notification.metrics;
      bool result = metrics.extentBefore > ScreenUtil().setWidth(170);
      if (result != showHeadimg && metrics.axis == Axis.vertical) {
        if (this.mounted) {
          setState(() {
            showHeadimg = result;
            sendEvent(MySliverAppBarEvent('showHeadImg', flag: showHeadimg));
            sendEvent(
                ButtonOfTopEvent('mine', 'changeFlag', flag: showHeadimg));
          });
        }
      }
    }
  }

  List<Widget> getHeader() {
    List<Widget> childs = [];
    childs.add(MySliverAppBar());
    childs.add(MyCard1());
    childs.add(MyCard2());
    childs.add(MyCard3());
    childs.add(SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(ThemeSize.marginSizeMax),
        child: HomeSmallTitle('猜你喜欢'),
      ),
    ));
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: ThemeColors.colorBg_F2F2F2,
      body: Stack(
        children: <Widget>[
          RefreshSliverList(
              TypeOfSliverGridView(2,
                  mainAxisSpacing: ScreenUtil().setWidth(10),
                  childAspectRatio: 0.7,
                  crossAxisSpacing: ThemeSize.marginSizeMin,
                  paddingLeft: ThemeSize.marginSizeMax,
                  paddingRight: ThemeSize.marginSizeMax),
              Apis.products_home,
              (item, index) {
                ModelItemProductEntity obj =
                    ModelItemProductEntity().fromJson(item);
                return ListItemOfProduct(obj, key: ValueKey(obj.id));
              },
              sliverHeader: getHeader(),
              tag: MinePage.pageTag,
              onNotification: (notification) {
                controlHeadImg(notification);
              }),
          ButtonOfTop(MinePage.pageTag)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
