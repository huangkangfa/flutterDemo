import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('我是发现'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
