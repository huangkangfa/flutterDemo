import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/pages/home/busi/busi_search_bar.dart';
import 'package:hello_world/widget/base_appbar.dart';

import 'busi/busi_view_mall.dart';

class ShoppingMallPage extends StatefulWidget {
  ShoppingMallPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShoppingMallPageState();
  }
}

class ShoppingMallPageState extends State<ShoppingMallPage>
    with AutomaticKeepAliveClientMixin<ShoppingMallPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: baseAppbar(context, '商城', Center(), Center()),
      body: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: ThemeSize.marginSizeMid,
                    right: ThemeSize.marginSizeMid),
                child: SearchBar(noLocationInfo: true),
              )),
          Expanded(flex: 1, child: MallView())
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
