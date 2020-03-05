import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
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
      margin: EdgeInsets.only(bottom: AppSize.marginSizeMid),
      padding: EdgeInsets.all(AppSize.marginSizeMax),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: AppSize.marginSizeMid),
            child: Row(
              children: <Widget>[
                Text('规格',
                    style: TextStyle(
                        fontSize: AppSize.fontSizeMid, color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.only(left: AppSize.marginSizeMid),
                  child: Text('未选择',
                      style: TextStyle(
                          fontSize: AppSize.fontSize14,
                          color: AppColors.C_333)),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text('运费',
                  style: TextStyle(
                      fontSize: AppSize.fontSizeMid, color: Colors.grey)),
              Padding(
                padding: EdgeInsets.only(left: AppSize.marginSizeMid),
                child: Text('全国包邮',
                    style: TextStyle(
                        fontSize: AppSize.fontSize14,
                        color: AppColors.C_333)),
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
