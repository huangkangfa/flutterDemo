import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_item_find_shop_entity.dart';
import 'package:hello_world/pages/home/busi/busi_search_bar.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_refresh_sliver_list.dart';
import 'package:hello_world/widget/base_toast.dart';

import 'busi/busi_find_banner.dart';
import 'busi/busi_find_index_gridview.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FindPageState();
  }
}

class FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin<FindPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: comAppbar(context, appBar: SearchBar()),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: RefreshSliverList(
            TypeOfSliverListView(),
            Apis.selectServerMchInfoPaging,
            (item, index) => buildItemLayout(item, index),
            sliverHeader: <Widget>[
              SliverToBoxAdapter(child: FindIndexGridView()),
              SliverToBoxAdapter(child: FindBanner()),
            ],
            scrollPhysics: BouncingScrollPhysics(),
            params: {'lat': 30.289374, 'lng': 120.036316, 'cityCode': 330100}),
      ),
    );
  }

  onClick(index) {
    showToast('点击了' + index.toString());
  }

  buildItemLayout(item, index) {
    ModelItemFindShopEntity shopEntity =
        ModelItemFindShopEntity().fromJson(item);
    return GestureDetector(
      onTap: () => onClick(index),
      child: Align(
        alignment: Alignment.topCenter,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
