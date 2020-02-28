import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/widget/base_appbar.dart';

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
      body: Center(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
