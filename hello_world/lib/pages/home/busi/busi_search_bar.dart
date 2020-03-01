import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/widget_edit_search.dart';

class SearchBar extends StatefulWidget {
  final bool noLocationInfo;

  SearchBar({this.noLocationInfo, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchBarState();
  }
}

class SearchBarState extends State<SearchBar> {
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = registerEvent<SearchBarEvent>((data) {
      if (data is SearchBarEvent) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget left = Center();
    if (widget.noLocationInfo == null || widget.noLocationInfo == false) {
      left = Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: ThemeSize.marginSizeMin),
            child: Icon(Icons.location_on, size: ThemeSize.fontSize22),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: ThemeSize.marginSizeMin,
                bottom: ThemeSize.marginSizeMin),
            child: Text('杭州', style: TextStyle(fontSize: ThemeSize.fontSize14)),
          )
        ],
      );
    }
    return comAppbar(
      context,
      left: left,
      center: EditSearchWidget(),
      right: Padding(
        padding: EdgeInsets.only(
            left: ThemeSize.marginSizeMin, right: ThemeSize.marginSizeMin),
        child: Icon(Icons.shopping_cart, size: ThemeSize.fontSize22),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}

class SearchBarEvent {
  String cmd;

  SearchBarEvent(this.cmd);
}