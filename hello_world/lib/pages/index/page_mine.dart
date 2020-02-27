import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin<MinePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text('我是我的'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
