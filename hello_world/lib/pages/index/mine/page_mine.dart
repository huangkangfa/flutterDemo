import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/pages/index/mine/busi/busi_mine_sliver_appbar.Dart';

import 'busi/busi_mine_card1.dart';
import 'busi/busi_mine_card2.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin<MinePage> {
  bool showHeadimg = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Widget> childs=[];
    childs.add(MySliverAppBar());
    childs.add(MyCard1());
    for(int i=0;i<20;i++){
      childs.add(MyCard2());
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        ScrollMetrics metrics = notification.metrics;
        bool result = metrics.extentBefore > ScreenUtil().setWidth(170);
        if (result != showHeadimg) {
          setState(() {
            showHeadimg = result;
            sendEvent(MySliverAppBarEvent('showHeadImg', flag: showHeadimg));
          });
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: ThemeColors.colorBg_F2F2F2,
        body: CustomScrollView(
          slivers: childs,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
