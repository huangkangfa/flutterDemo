import 'package:flutter/material.dart';
import 'package:hello_world/pages/index/page_find.dart';
import 'package:hello_world/pages/index/home/page_home.dart';
import 'package:hello_world/pages/index/page_member.dart';
import 'package:hello_world/pages/index/page_mine.dart';
import 'package:hello_world/pages/index/page_shopping_mall.dart';
import 'package:hello_world/widget/drawer_wdiget.dart';

class MyNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigatorState();
  }
}

class NavigatorState extends State<MyNavigator> {
  int _currentIndex = 0;
  String appBarTitle = BottomNavigationBarData.TITLES[0];
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            HomePage(),
            ShoppingMallPage(),
            MemberPage(),
            FindPage(),
            MinePage()
          ],
          onPageChanged: (index) {
            setState(() {
              _setAppBarTitle(index);
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              // 点击跳转对应的PageView
              _pageController.jumpToPage(index);
              setState(() {
                _setAppBarTitle(index);
              });
            },
            currentIndex: _currentIndex,
            items: BottomNavigationBarData.getBottomNavigationBarItems()));
  }

  //切换tab页变更操作
  _setAppBarTitle(index) {
    _currentIndex = index;
    appBarTitle = BottomNavigationBarData.TITLES[_currentIndex];
  }
}

//底部栏配置数据
class BottomNavigationBarData {
  static const TITLES = ['首页', '商城', '会员', '发现', '我的'];
  static const ICONS = [
    Icons.home,
    Icons.add_shopping_cart,
    Icons.person_pin,
    Icons.camera,
    Icons.person
  ];
  static const COLORS = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  static getBottomNavigationBarItems() {
    var bottomNavigationBarData = <BottomNavigationBarItem>[];
    for (int i = 0; i < BottomNavigationBarData.TITLES.length; i++) {
      bottomNavigationBarData.add(new BottomNavigationBarItem(
          icon: Icon(BottomNavigationBarData.ICONS[i]),
          title: Text(BottomNavigationBarData.TITLES[i]),
          backgroundColor: BottomNavigationBarData.COLORS[i]));
    }
    return bottomNavigationBarData;
  }
}
