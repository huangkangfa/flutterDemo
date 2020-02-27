import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MemberPageState();
  }
}

class MemberPageState extends State<MemberPage>
    with AutomaticKeepAliveClientMixin<MemberPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text('我是会员'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
