import 'package:flutter/material.dart';
import 'package:hello_world/pages/home/busi/busi_search_bar.dart';
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
      appBar: comAppbar(context, appBar: SearchBar()),
      body: Center(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
