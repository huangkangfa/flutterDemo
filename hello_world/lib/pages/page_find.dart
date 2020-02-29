import 'package:flutter/material.dart';
import 'package:hello_world/widget/base_appbar.dart';

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
      appBar: baseAppbar(context, '发现', Center(), Center()),
      body: Center(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
