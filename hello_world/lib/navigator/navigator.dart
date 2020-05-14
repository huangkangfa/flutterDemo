import 'package:flutter/material.dart';
import 'package:hello_world/pages/find/page_find.dart';
import 'package:hello_world/pages/home/page_home.dart';
import 'package:hello_world/pages/mall/page_shopping_mall.dart';
import 'package:hello_world/pages/mine/page_mine.dart';
import 'package:hello_world/pages/page_member.dart';
import 'package:hello_world/widget/drawer_wdiget.dart';

import 'bottom_bar.dart';

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
        resizeToAvoidBottomPadding: true,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(),
            ShoppingMallPage(),
            MemberPage(),
            FindPage(),
            MinePage()
          ],
          onPageChanged: (index) {
            if (this.mounted) {
              setState(() {
                _setAppBarTitle(index);
              });
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              // 点击跳转对应的PageView
              _pageController.jumpToPage(index);
              if (this.mounted) {
                setState(() {
                  _setAppBarTitle(index);
                });
              }
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
