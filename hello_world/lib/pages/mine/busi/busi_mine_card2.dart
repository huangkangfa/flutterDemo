import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_com_icon_entity.dart';
import 'package:hello_world/pages/home/page_home.dart';
import 'package:hello_world/util/util_screen.dart';

class MyCard2 extends StatelessWidget {
  final List<ModelComIconEntity> data = [
    ModelComIconEntity(
        name: '待付款',
        img:'images/icon_order_pending_payment.png'),
    ModelComIconEntity(
        name: '未使用',
        img:'images/icon_order_unused.png'),
    ModelComIconEntity(
        name: '待收货',
        img:'images/icon_order_to_be_delivered.png'),
    ModelComIconEntity(
        name: '待评价',
        img:'images/icon_order_comment.png'),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> childs = [];
    for (int i = 0; i < data.length; i++) {
      childs.add(buildItemLayout(i));
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
                    child: HomeSmallTitle('订单'),
                  ),
                ),
                Row(
                  children: childs,
                )
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
