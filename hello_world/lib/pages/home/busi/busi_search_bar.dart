import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_event_stateful.dart';
import 'package:hello_world/widget/widget_edit_search.dart';

class SearchBar extends StatefulWidget {
  final bool noLocationInfo;

  SearchBar({this.noLocationInfo, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchBarState();
  }
}

class SearchBarState extends EventStateful<SearchBar, SearchBarEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void doThingsForEvent(SearchBarEvent data) {}

  @override
  Widget build(BuildContext context) {
    Widget left = Center();
    if (widget.noLocationInfo == null || widget.noLocationInfo == false) {
      left = Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: AppSize.marginSizeMin),
            child: Icon(Icons.location_on, size: AppSize.fontSize22),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: AppSize.marginSizeMin,
                bottom: AppSize.marginSizeMin),
            child: Text('杭州', style: TextStyle(fontSize: AppSize.fontSize14)),
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
            left: AppSize.marginSizeMin, right: AppSize.marginSizeMin),
        child: Icon(Icons.shopping_cart, size: AppSize.fontSize22),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SearchBarEvent {
  String cmd;

  SearchBarEvent(this.cmd);
}
