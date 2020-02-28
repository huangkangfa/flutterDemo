//刷新状态枚举
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class RefreshSliverList extends StatefulWidget {
  RefreshSliverList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new RefreshSliverListState();
  }
}

class RefreshSliverListState extends State<RefreshSliverList> {
  ScrollController _controller;
  int _count = 10;
  bool _isLoding = false;
  bool _isRefreshing = false;
  String loadingText = "加载中.....";

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  initScrollListener(ScrollNotification notification){
    ScrollMetrics metrics = notification.metrics;
    print(metrics.pixels);// 当前位置
    print(metrics.atEdge);//是否在顶部或底部
    print(metrics.axis);//垂直或水平滚动
    print(metrics.axisDirection);// 滚动方向是down还是up
    print(metrics.extentAfter);//视口底部距离列表底部有多大
    print(metrics.extentBefore);//视口顶部距离列表顶部有多大
    print(metrics.extentInside);//视口范围内的列表长度
    print(metrics.maxScrollExtent);//最大滚动距离，列表长度-视口长度
    print(metrics.minScrollExtent);//最小滚动距离
    print(metrics.viewportDimension);//视口长度
    print(metrics.outOfRange);//是否越过边界
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification &&
            notification.depth == 0 &&
            !_isLoding &&
            !_isRefreshing) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            setState(() {
              _isLoding = true;
              loadingText = "加载中.....";
              _count += 10;
            });
            _RrefreshPull().then((value) {
              print('加载成功.............');
              setState(() {
                _isLoding = false;
              });
            }).catchError((error) {
              print('failed');
              setState(() {
                _isLoding = true;
                loadingText = "加载失败.....";
              });
            });
          }
        }
        return false;
      },
      child: RefreshIndicator(
        child: CustomScrollView(
          controller: _controller,
          physics: ScrollPhysics(),
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              title: const Text('复杂布局'),
//                    expandedHeight: 150.0,
//                    flexibleSpace: FlexibleSpaceBar(
//                      collapseMode: CollapseMode.parallax,
//                      title: Text(
//                        '复杂布局',
//                        style: TextStyle(fontSize: 16),
//                      ),
//                    ),
              elevation: 10,
              leading: Icon(Icons.arrow_back),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      "http://pic37.nipic.com/20140113/8800276_184927469000_2.png",
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: 3,
                  pagination: new SwiperPagination(),
                ),
              ),
            ),
            new SliverToBoxAdapter(
              child: new Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: new Column(
                  children: <Widget>[
                    new SizedBox(
                        child: new Text(
                      'SliverGrid',
                      style: new TextStyle(fontSize: 16),
                    )),
                    new Divider(
                      color: Colors.grey,
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('SliverGrid item $index'),
                  );
                },
                childCount: _count,
              ),
            ),
            new SliverToBoxAdapter(
                child: new Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.green,
              child: new SizedBox(
                  child: new Text(
                'SliverFixedExtentList',
                style: new TextStyle(fontSize: 16),
              )),
            )),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('SliverFixedExtentList item $index'),
                  );
                },
                childCount: _count + 20,
              ),
            ),
            new SliverToBoxAdapter(
                child: new Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.green,
              child: new SizedBox(
                  child: new Text(
                'SliverGrid',
                style: new TextStyle(fontSize: 16),
              )),
            )),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('SliverGrid item2 $index'),
                  );
                },
                childCount: _count + 10,
              ),
            ),
            new SliverToBoxAdapter(
              child: new Visibility(
                child: new Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: new Center(
                    child: new Text(loadingText),
                  ),
                ),
                visible: _isLoding,
              ),
            ),
          ],
        ),
        onRefresh: () {
          if (_isLoding) return null;
          return _RrefreshPull().then((value) {
            print('success');
            setState(() {
              _count += 10;
            });
          }).catchError((error) {
            print('failed');
          });
        },
      ),
    );
  }

  Future<String> _RrefreshPull() async {
    await Future.delayed(new Duration(seconds: 3));
    return "_RrefreshPull";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
