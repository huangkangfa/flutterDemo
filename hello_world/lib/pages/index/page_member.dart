import 'package:flutter/material.dart';
import 'package:hello_world/widget/base_appbar.dart';

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
      appBar: baseAppbar(context, '会员', Center(), Center()),
      body: Center(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
