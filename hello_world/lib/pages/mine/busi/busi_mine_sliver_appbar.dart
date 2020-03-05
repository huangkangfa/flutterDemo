import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/default_set.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_event_stateful.dart';
import 'package:hello_world/widget/base_toast.dart';

class MySliverAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MySliverAppBarState();
  }
}

class MySliverAppBarState
    extends EventStateful<MySliverAppBar, MySliverAppBarEvent> {
  double headerWH = ScreenUtil().setWidth(40);
  bool showHeadImg = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModelUserEntity>(
        converter: (store) => store.state.userInfo,
        builder: (context, userInfo) {
          return SliverAppBar(
            leading: Visibility(
              visible: showHeadImg,
              child: Container(
                child: Center(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          userInfo?.headImg ?? DefaultPersion.defaultHeadImg,
                      height: headerWH,
                      width: headerWH,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  showToast('点击更多');
                },
              ),
            ],
            //阴影的高度
            elevation: 1,
            //是否显示阴影
            forceElevated: true,
            backgroundColor: ThemeColors.primary,
            brightness: Brightness.light,
            //appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
            primary: true,
            //标题两边的空白区域
            titleSpacing: ThemeSize.marginSizeMax,
            //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
            expandedHeight: ScreenUtil().setWidth(250),
            //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
            floating: false,
            //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
            pinned: true,
            //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: userInfo?.headImg ?? DefaultPersion.defaultHeadImg,
                fit: BoxFit.cover,
              ),
              title: Container(
                constraints: BoxConstraints(maxWidth: ScreenUtil.screenWidthDp),
                child: Text(userInfo?.name ?? DefaultPersion.name,
                    style: TextStyle(color: Colors.white, shadows: <Shadow>[
                      Shadow(color: Colors.black26, offset: Offset(0, 1)),
                    ])),
              ),
              centerTitle: false,
              collapseMode: CollapseMode.pin,
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void doThingsForEvent(MySliverAppBarEvent data) {
    switch (data.cmd) {
      case 'showHeadImg':
        if (this.mounted) {
          setState(() {
            showHeadImg = data.flag;
          });
        }
        break;
    }
  }
}

class MySliverAppBarEvent {
  String cmd;
  bool flag;

  MySliverAppBarEvent(this.cmd, {this.flag});
}
