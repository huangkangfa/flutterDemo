import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/widget/base_event_stateful.dart';

class ProductSelect extends StatefulWidget {
  @override
  _ProductSelectState createState() => _ProductSelectState();
}

class _ProductSelectState
    extends EventStateful<ProductSelect, ProductSelectEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: ThemeSize.marginSizeMid),
      padding: EdgeInsets.all(ThemeSize.marginSizeMax),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: ThemeSize.marginSizeMid),
            child: Row(
              children: <Widget>[
                Text('规格',
                    style: TextStyle(
                        fontSize: ThemeSize.fontSizeMid, color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.only(left: ThemeSize.marginSizeMid),
                  child: Text('未选择',
                      style: TextStyle(
                          fontSize: ThemeSize.fontSize14,
                          color: ThemeColors.colorFont_333)),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text('运费',
                  style: TextStyle(
                      fontSize: ThemeSize.fontSizeMid, color: Colors.grey)),
              Padding(
                padding: EdgeInsets.only(left: ThemeSize.marginSizeMid),
                child: Text('全国包邮',
                    style: TextStyle(
                        fontSize: ThemeSize.fontSize14,
                        color: ThemeColors.colorFont_333)),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void doThingsForEvent(ProductSelectEvent data) {}
}

class ProductSelectEvent {
  String cmd;

  ProductSelectEvent(this.cmd);
}
