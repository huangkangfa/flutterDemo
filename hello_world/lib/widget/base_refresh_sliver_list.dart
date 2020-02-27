//刷新状态枚举
import 'package:flutter/cupertino.dart';

enum LoadingStatus {
  //正在加载中
  STATUS_LOADING,
  //数据加载完毕
  STATUS_COMPLETED,
  //空闲状态
  STATUS_IDEL
}

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

  @override
  Widget build(BuildContext context) {
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}
