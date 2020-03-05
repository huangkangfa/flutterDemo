import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_route_jump.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_event_stateful.dart';
import 'package:hello_world/widget/base_toast.dart';

import 'busi_product_body.dart';

class ProductHeader extends StatefulWidget {
  ProductHeader({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductHeaderState();
  }
}

class ProductHeaderState
    extends EventStateful<ProductHeader, ProductHeaderEvent> {
  bool isShowHeader = false;
  int indexOfHeader = 0;

  @override
  void initState() {
    super.initState();
  }

  onClick(int index) {
    if (indexOfHeader == index) return;
    setState(() {
      indexOfHeader = index;
      sendEvent(ProductBodyEvent('changeIndexOfHeader', num: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: ScreenUtil().setWidth(70)),
      color: isShowHeader ? Colors.white : AppColors.TRANSPARENT,
      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
      child: comAppbar(context,
          center: Visibility(
            visible: isShowHeader,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HeaderTitleTypeItem(
                    name: '商品',
                    hasLine: indexOfHeader == 0,
                    onClick: () => onClick(0)),
                HeaderTitleTypeItem(
                    name: '评价',
                    hasLine: indexOfHeader == 1,
                    onClick: () => onClick(1)),
                HeaderTitleTypeItem(
                    name: '详情',
                    hasLine: indexOfHeader == 2,
                    onClick: () => onClick(2)),
              ],
            ),
          ),
          left: GestureDetector(
            onTap: () => pop(context),
            child: Padding(
              padding: EdgeInsets.only(left: AppSize.marginSizeMid),
              child: ClipOval(
                  child: Container(
                      color: Color(isShowHeader ? 0x00000000 : 0x30000000),
                      child: Padding(
                        padding: EdgeInsets.all(AppSize.marginSizeMin),
                        child: Icon(Icons.arrow_back_ios,
                            color: isShowHeader ? Colors.black : Colors.white,
                            size: AppSize.fontSize20),
                      ))),
            ),
          ),
          right: GestureDetector(
              onTap: () => showToast('分享'),
              child: Padding(
                padding: EdgeInsets.only(right: AppSize.marginSizeMid),
                child: ClipOval(
                    child: Container(
                        color: Color(isShowHeader ? 0x00000000 : 0x30000000),
                        child: Padding(
                          padding: EdgeInsets.all(AppSize.marginSizeMin),
                          child: Icon(Icons.share,
                              size: AppSize.fontSize20,
                              color:
                                  isShowHeader ? Colors.black : Colors.white),
                        ))),
              )),
          backgroundColor: isShowHeader ? Colors.white : AppColors.TRANSPARENT,
          top: false),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void doThingsForEvent(ProductHeaderEvent data) {
    switch (data.cmd) {
      case 'isShowHeader':
        setState(() {
          isShowHeader = data.flag ?? false;
        });
        break;
      case 'type_0':
        setState(() {
          indexOfHeader = 0;
        });
        break;
      case 'type_1':
        setState(() {
          indexOfHeader = 1;
        });
        break;
      case 'type_2':
        setState(() {
          indexOfHeader = 2;
        });
        break;
    }
  }
}

class HeaderTitleTypeItem extends StatelessWidget {
  final String name;
  final bool hasLine;
  final Function onClick;

  HeaderTitleTypeItem(
      {@required this.name, this.hasLine, this.onClick, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) onClick();
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: AppSize.marginSizeMid, right: AppSize.marginSizeMid),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name, style: TextStyle(fontSize: AppSize.fontSizeMid)),
            Container(
              color: hasLine ? null : Colors.white,
              margin: EdgeInsets.only(top: 3),
              constraints: BoxConstraints(
                minHeight: ScreenUtil().setWidth(3),
                minWidth: ScreenUtil().setWidth(18),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductHeaderEvent {
  String cmd;
  bool flag;

  ProductHeaderEvent(this.cmd, {this.flag});
}
