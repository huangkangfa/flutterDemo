import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_com_icon_entity.dart';
import 'package:hello_world/pages/home/page_home.dart';
import 'package:hello_world/util/util_screen.dart';

class MyCard3 extends StatelessWidget {
  final List<ModelComIconEntity> data = [
    ModelComIconEntity(
        name: '购物车',
        img:'images/icon_shop_car.png'),
    ModelComIconEntity(
        name: '我的收藏',
        img:'images/icon_collection.png'),
    ModelComIconEntity(
        name: '优惠券',
        img:'images/icon_coupon.png'),
    ModelComIconEntity(
        name: '直播中心',
        img:'images/icon_live.png'),
    ModelComIconEntity(
        name: '邀请好友',
        img:'images/icon_invite_friends.png'),
    ModelComIconEntity(
        name: '我要合作',
        img:'images/icon_cooperate.png'),
    ModelComIconEntity(
        name: '官方咨询',
        img:'images/icon_consultation.png'),
    ModelComIconEntity(
        name: '设置',
        img:'images/icon_setting.png'),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> childs1 = [];
    List<Widget> childs2 = [];
    int mid = data.length~/2;
    for (int i = 0; i < mid; i++) {
      childs1.add(buildItemLayout(i));
    }
    for (int i = mid; i < data.length; i++) {
      childs2.add(buildItemLayout(i));
    }
    return SliverPadding(
      padding: EdgeInsets.only(left:ThemeSize.marginSizeMax,right:ThemeSize.marginSizeMax,bottom: ThemeSize.marginSizeMax),
      sliver: SliverToBoxAdapter(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child:Padding(
                    padding: EdgeInsets.only(left: ThemeSize.marginSizeMid),
                    child: HomeSmallTitle('其他'),
                  ),
                ),
                Row(
                  children: childs1,
                ),
                Row(
                  children: childs2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItemLayout(int index) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: ThemeSize.marginSizeMax, bottom: ThemeSize.marginSizeMax),
          child: Column(
            children: <Widget>[
              Image.asset(
                data[index].img,
                height: ScreenUtil().setWidth(40),
                width: ScreenUtil().setWidth(40),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(top: ThemeSize.marginSizeMid),
                child: Text(data[index].name,
                    style: TextStyle(
                        fontSize: ThemeSize.fontSize14,
                        color: ThemeColors.colorFont_333)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
