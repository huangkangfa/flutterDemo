//底部栏配置数据
import 'package:flutter/material.dart';

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
      bottomNavigationBarData.add(BottomNavigationBarItem(
          icon: Icon(BottomNavigationBarData.ICONS[i]),
          title: Text(BottomNavigationBarData.TITLES[i]),
          backgroundColor: BottomNavigationBarData.COLORS[i]));
    }
    return bottomNavigationBarData;
  }
}