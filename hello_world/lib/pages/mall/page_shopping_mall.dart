import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: comAppbar(context, appBar: SearchBar()),
      body: MallView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
