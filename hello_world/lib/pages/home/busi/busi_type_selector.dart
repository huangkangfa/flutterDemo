import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/widget/base_event_stateful.dart';

class TypeSelector extends StatefulWidget {
  final String tag;
  final Function onTap;

  TypeSelector(this.tag, {Key key, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new TypeSelectorState();
  }
}

class TypeSelectorState extends EventStateful<TypeSelector, TypeSelectorEvent> {
  int selectedIndex = 1;
  List<TypeSelectorItem> data = [
    TypeSelectorItem('好评', Icons.bookmark),
    TypeSelectorItem('距离最近', Icons.unfold_more),
  ];

  @override
  void initState() {
    super.initState();
  }

  onClick(index) {
    if (index != selectedIndex) {
      if (widget.onTap != null) {
        widget.onTap(index);
      }
      if (this.mounted) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childs = [];
    for (int i = 0; i < data.length; i++) {
      childs.add(GestureDetector(
        onTap: () {
          onClick(i);
        },
        child: Padding(
          padding: EdgeInsets.only(
              right: i == data.length - 1 ? 0 : AppSize.marginSizeMid),
          child: Row(
            children: <Widget>[
              Icon(data[i].icon,
                  size: AppSize.fontSizeMid,
                  color: selectedIndex == i ? null : Colors.grey),
              Text(
                data[i].name,
                style: TextStyle(
                    color: selectedIndex == i ? AppColors.C_333 : Colors.grey),
              ),
            ],
          ),
        ),
      ));
    }
    return Row(
      children: childs,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void doThingsForEvent(TypeSelectorEvent data) {}
}

class TypeSelectorEvent {
  String cmd;

  TypeSelectorEvent(this.cmd);
}

class TypeSelectorItem {
  String name;
  IconData icon;

  TypeSelectorItem(this.name, this.icon);
}
