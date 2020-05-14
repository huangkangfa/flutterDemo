import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/configs/app_default.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/configs/index.dart';
import 'package:hello_world/configs/app_keys.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/native/native_test.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/redux/reducer/reducer_user.dart';
import 'package:hello_world/util/util_route_jump.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_dialog.dart';

import 'base_sp.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {
  String content = "展示结果";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModelUserEntity>(
      converter: (store) => store.state.userInfo,
      builder: (context, userInfo) {
        var children = initLayout(userInfo);
        return Container(
          width: ScreenUtil().setWidth(200),
          child: Drawer(
              child: Column(
            children: children,
          )),
        );
      },
    );
  }

  ///登录
  login() {
    showToast("登录成功");
    StoreProvider.of<AppState>(context).dispatch(RefreshUserDataAction(
        ModelUserEntity(
            name: "黄康发",
            headImg:
                "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3707479485,672728468&fm=26&gp=0.jpg")));
  }

  ///退出登录
  loginOut() {
    showToast('退出登录成功');
    StoreProvider.of<AppState>(context).dispatch(RefreshUserDataAction(null));
  }

  ///检测登录并执行后续操作
  checkLogin(isLogin) {
    if (isLogin) {
      login();
    } else {
      showToast('进入个人详情');
    }
  }

  ///初始化子布局
  initLayout(userInfo) {
    NativeTest.basicMessageChannel.setMessageHandler(
          (String message) => Future<String>(() {
            setState(() {
              content = message;
            });
        return "回复native消息";
      }),
    );

    var children = <Widget>[
      getHeadItems(userInfo),
      ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text("仿ios提示框"),
        onTap: () {
          showPromptDialog(context, title: '温馨提示', content: '哈哈哈哈哈哈哈哈哈哈嘿嘿嘿');
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("底部弹窗"),
        onTap: () {
          showActionsSheet(context, data: [
            ActionsSheetData(
                name: '拍照',
                callback: () {
                  pop<String>(context, obj: '拍照');
                }),
            ActionsSheetData(
                name: '从相册中选择',
                callback: () {
                  pop<String>(context, obj: '从相册中选择');
                })
          ]);
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text("自定义弹框"),
        onTap: () {
          showAnyDialog(context,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.marginSizeMid),
                child: CachedNetworkImage(
                  imageUrl: AppDefault.DEFAULT_IMG_HEAD,
                  height: ScreenUtil().setWidth(200),
                  width: ScreenUtil().setWidth(200),
                  fit: BoxFit.cover,
                ),
              ));
        },
      ),
      ListTile(
        leading: Icon(Icons.grade),
        title: Text("广告页开关"),
        onTap: () {
          bool switchOfAd = SpUtil.getBool(AppKeys.SWITCH_AD, defValue: true);
          showToast('广告页 ' + (switchOfAd ? '关闭' : '开启'));
          SpUtil.putBool(AppKeys.SWITCH_AD, !switchOfAd);
        },
      ),
      ListTile(
        leading: Icon(Icons.account_balance),
        title: Text("主题切换"),
        onTap: () {
          int index = SpUtil.getInt(AppKeys.THEME_INDEX, defValue: 0);
          SpUtil.putInt(AppKeys.THEME_INDEX, index == 0 ? 1 : 0);
          Config.resetTheme(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.account_balance),
        title: Text("跳转至原生界面"),
        onTap: () {
          NativeTest.goToNativePage();
        },
      ),
      ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text("MethodChannel,F->N"),
        onTap: () {
          NativeTest.testMethodChannel().then((value) {
            setState(() {
              content = value;
            });
          });
        },
      ),
      ListTile(
        leading: Icon(Icons.details),
        title: Text(content??"数据为空"),
      ),
      Container(
        width: 200,
        height: 100,
        child: AndroidView(
          viewType: "com.flutter.demo/android_view",
        ),
      )
    ];
    if (userInfo != null) {
      children.add(Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
        child: ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("退出登录"),
          onTap: () {
            loginOut();
          },
        ),
      ));
    }
    return children;
  }

  ///获取头部
  getHeadItems(userInfo) {
    return Container(
      alignment: Alignment.topLeft,
      height: ScreenUtil().setHeight(150),
      color: Theme.of(context).accentColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
                child: GestureDetector(
                  onTap: () {
                    checkLogin(userInfo == null);
                  },
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          userInfo?.headImg ?? AppDefault.DEFAULT_IMG_HEAD,
                      height: ScreenUtil().setWidth(80),
                      width: ScreenUtil().setWidth(80),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(5)),
                child: GestureDetector(
                  onTap: () {
                    checkLogin(userInfo == null);
                  },
                  child: Text(
                    userInfo?.name ?? AppDefault.UNLOGIN_NAME,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
