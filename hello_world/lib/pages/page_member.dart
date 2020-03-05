import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_default.dart';
import 'package:hello_world/util/util_screen.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MemberPageState();
  }
}

class MemberPageState extends State<MemberPage>
    with AutomaticKeepAliveClientMixin<MemberPage> {
  final _tabs = <String>['TabA', 'TabB'];
  final colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.deepPurple
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerScrolled) => <Widget>[
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: ScreenUtil().setWidth(200),
                      flexibleSpace: FlexibleSpaceBar(
                        background: CachedNetworkImage(
                          imageUrl: AppDefault.DEFAULT_IMG_HEAD,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text('会员',
                          style:
                              TextStyle(color: Colors.white, shadows: <Shadow>[
                            Shadow(color: Colors.black26, offset: Offset(0, 1)),
                          ])),
                      centerTitle: true,
                      backgroundColor: Colors.blue,
                      bottom: TabBar(
                          indicatorColor: Colors.red,
                          tabs: _tabs
                              .map((tab) => Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(tab,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              shadows: <Shadow>[
                                                Shadow(
                                                    color: Colors.black26,
                                                    offset: Offset(0, 1)),
                                              ])),
                                    ),
                                  ))
                              .toList()),
                      forceElevated: innerScrolled,
                    )
                  ],
              body: TabBarView(
                  children: _tabs
                      // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
                      // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
                      .map((tab) => Builder(
                            builder: (context) => CustomScrollView(
                              // key 保证唯一性
                              key: PageStorageKey<String>(tab),
                              slivers: <Widget>[
                                SliverFixedExtentList(
                                    delegate: SliverChildBuilderDelegate(
                                        (_, index) => Container(
                                            child: Text(
                                                '$tab - item${index + 1}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: colors[index % 6])),
                                            alignment: Alignment.center),
                                        childCount: 15),
                                    itemExtent: 50.0)
                              ],
                            ),
                          ))
                      .toList()))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
