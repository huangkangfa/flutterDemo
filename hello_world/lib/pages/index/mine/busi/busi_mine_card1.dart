import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_com_icon_entity.dart';
import 'package:hello_world/util/util_screen.dart';

class MyCard1 extends StatelessWidget {
  final List<ModelComIconEntity> data = [
    ModelComIconEntity(
        name: '消息',
        img:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582918869288&di=15c42b4f3d3c15e252c2767ca5632b6b&imgtype=0&src=http%3A%2F%2Fku.90sjimg.com%2Felement_origin_min_pic%2F00%2F24%2F82%2F8856d00ea961ccc.jpg'),
    ModelComIconEntity(
        name: '签到',
        img:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582918983439&di=282445e6a5cc18220f44c0d4faa2d57d&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F7e989165784c9c159cc3fd075f6c715b1e1e1e2f3a3e-KzR6gj_fw658'),
    ModelComIconEntity(
        name: '积分',
        img:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582919024353&di=312bc3aac524f994c79dfa99ef568804&imgtype=0&src=http%3A%2F%2Fpic.downcc.com%2Fupload%2F2018-5%2F20185111653247870.png'),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> childs = [];
    for (int i = 0; i < data.length; i++) {
      childs.add(buildItemLayout(i));
    }
    return SliverPadding(
      padding: EdgeInsets.all(ThemeSize.marginSizeMax),
      sliver: SliverToBoxAdapter(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300], width: 1.0),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8))),
            child: Row(
              children: childs,
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
              ClipOval(
                child: Image.network(
                  data[index].img,
                  height: ScreenUtil().setWidth(40),
                  width: ScreenUtil().setWidth(40),
                  fit: BoxFit.cover,
                ),
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
