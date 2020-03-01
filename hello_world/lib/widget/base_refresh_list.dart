import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/model/model_refresh_list_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/http/result_data.dart';

//刷新状态枚举
enum LoadingStatus {
  //正在加载中
  STATUS_LOADING,
  //数据加载完毕
  STATUS_COMPLETED,
  //空闲状态
  STATUS_IDEL
}

//展示类型
abstract class RefreshListType {}

class TypeOfListView extends RefreshListType {
  final Widget header;

  TypeOfListView({this.header});
}

class TypeOfGridView extends RefreshListType {
  final double columnCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final double paddingLeft, paddingTop, paddingRight, paddingBottom, padding;

  TypeOfGridView(this.columnCount,
      {this.mainAxisSpacing,
      this.crossAxisSpacing,
      this.childAspectRatio,
      this.padding,
      this.paddingLeft,
      this.paddingTop,
      this.paddingRight,
      this.paddingBottom});
}

class RefreshList extends StatefulWidget {
  //请求api
  final String api;
  final Function buildItemLayout;
  final Function onRefresh;
  final RefreshListType type;

  //空背景
  final Widget emptyBg;

  RefreshList(this.type, this.api, this.buildItemLayout,
      {Key key, this.emptyBg, this.onRefresh})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RefreshListState();
  }
}

class RefreshListState extends State<RefreshList> {
  CancelToken tag = CancelToken();

  //是否是加载前的界面
  bool isBeforeLoaded = true;

  //数据源
  List list = List();

  //foot文本
  String loadingText = '加载中...';

  //当前请求的最大数据量
  int pageSize = 20;

  //当前请求的页码
  int pageNo = 1;

  //总数据大小
  int total = 999;

  //当前上拉加载更多的状态
  LoadingStatus loadingStatus = LoadingStatus.STATUS_IDEL;

  //滑动控制器
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      //判断滑到底部的时候,触发加载更多
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        getData(false);
      }
    });

    //第一页数据请求
    getData(true);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.type is TypeOfGridView) {
      TypeOfGridView typeOfGridView = widget.type as TypeOfGridView;
      double mainAxisSpacing = typeOfGridView.mainAxisSpacing ?? 0;
      double crossAxisSpacing = typeOfGridView.crossAxisSpacing ?? 0;
      double childAspectRatio = typeOfGridView.childAspectRatio ?? 1;
      double paddingBottom =
          typeOfGridView.padding ?? typeOfGridView.paddingBottom ?? 0;
      double paddingLeft =
          typeOfGridView.padding ?? typeOfGridView.paddingLeft ?? 0;
      double paddingRight =
          typeOfGridView.padding ?? typeOfGridView.paddingRight ?? 0;
      double paddingTop =
          typeOfGridView.padding ?? typeOfGridView.paddingTop ?? 0;

      double columnCount = typeOfGridView.columnCount;
      child = Padding(
        padding: EdgeInsets.only(
            top: paddingTop,
            bottom: paddingBottom,
            right: paddingRight,
            left: paddingLeft),
        child: GridView.builder(
          controller: controller,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            if (list.length == 0) {
              return Center();
            }
            return widget.buildItemLayout(list[index], index);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //子项宽高比
              childAspectRatio: childAspectRatio,
              //单个子Widget的水平最大宽度
              crossAxisCount: columnCount.toInt(),
              //水平单个子Widget之间间距
              mainAxisSpacing: mainAxisSpacing,
              //垂直单个子Widget之间间距
              crossAxisSpacing: crossAxisSpacing),
        ),
      );
    } else {
      TypeOfListView typeOfListView = widget.type as TypeOfListView;
      int temp = typeOfListView.header == null ? 0 : 1;
      child = ListView.builder(
          controller: controller,
          itemCount: list.length + 1 + temp,
          itemBuilder: (BuildContext context, int index) {
            if (list.length == 0) {
              return Center();
            }
            if (index == list.length + temp) {
              return getLoadingView();
            } else if (temp > 0 && index == 0) {
              return typeOfListView.header;
            } else {
              return widget.buildItemLayout(list[index - temp], index - temp);
            }
          });
    }

    return Stack(
      children: <Widget>[
        RefreshIndicator(
          onRefresh: _onRefresh,
          child: child,
        ),
        Offstage(
          offstage: list.length > 0,
          child: Container(
            alignment: Alignment.center,
            child: widget.emptyBg ?? getDefaultEmptyBg(),
          ),
        )
      ],
    );
  }

  Future<void> _onRefresh() async {
    if (widget.onRefresh != null) {
      widget.onRefresh();
    }
    getData(true);
  }

  Future getData(bool isFirst) async {
    if (isFirst) {
      //下拉刷新或者第一次加载数据
      loadingStatus = LoadingStatus.STATUS_LOADING;
      loadingText = '加载中...';
      list.clear();
      pageNo = 1;
      List listMore = await requstData(
          widget.api, {'pageNo': pageNo, 'pageSize': pageSize});
      if(this.mounted){
        setState(() {
          list.addAll(listMore);
          if (list.length >= total) {
            loadingText = '';
            loadingStatus = LoadingStatus.STATUS_COMPLETED;
          } else {
            loadingStatus = LoadingStatus.STATUS_IDEL;
          }
        });
      }
    } else {
      //避免重复加载更多
      if (loadingStatus == LoadingStatus.STATUS_IDEL) {
        if(this.mounted){
          setState(() {
            loadingStatus = LoadingStatus.STATUS_LOADING;
          });
        }
        pageNo++;
        //获取增联数据赋值listMore
        List listMore = await requstData(
            widget.api, {'pageNo': pageNo, 'pageSize': pageSize});
        //准备完数据，再设置状态
        if(this.mounted){
          setState(() {
            if (list.length < total) {
              list.addAll(listMore);
              loadingStatus = LoadingStatus.STATUS_IDEL;
              loadingText = '加载中...';
            } else {
              loadingText = '没有更多数据了';
              loadingStatus = LoadingStatus.STATUS_COMPLETED;
            }
          });
        }
      }
    }
  }

  Future<List<dynamic>> requstData(api, params) async {
    ResultData resultData =
        await HttpManager.getInstance().get(api, params, cancelToken: tag);
    if (resultData == null) return [];
    //总数据量赋值
    ModelRefreshListEntity result =
        ModelRefreshListEntity().fromJson(resultData.result);
    if (total != result.total) total = result.total;
    return result.data;
  }

  //上拉加载中的布局
  Widget getLoadingView() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
              visible: loadingStatus == LoadingStatus.STATUS_LOADING,
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(loadingText,
                style: TextStyle(
                    color: ThemeColors.colorFont_333,
                    fontSize: ThemeSize.fontSizeMid)),
          )
        ],
      ),
    );
  }

  //默认空背景图
  Widget getDefaultEmptyBg() {
    if (isBeforeLoaded) {
      isBeforeLoaded = false;
      return CircularProgressIndicator();
    }
    return Text('空空如也~');
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    HttpManager.getInstance().cancelRequests(tag);
  }
}
