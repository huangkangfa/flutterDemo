import 'package:flutter/cupertino.dart';

class ComGridView extends StatelessWidget {
  final double paddingLeft, paddingTop, paddingRight, paddingBottom, padding;
  final double mainAxisSpacing, crossAxisSpacing;
  final Widget emptyBg;
  final Function buildItemLayout;
  final List data;
  final columnCount;

  ComGridView(this.data, this.buildItemLayout, this.columnCount,
      {Key key,
      this.mainAxisSpacing,
      this.crossAxisSpacing,
      this.paddingLeft,
      this.paddingTop,
      this.paddingRight,
      this.paddingBottom,
      this.padding,
      this.emptyBg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.length == 0) return emptyBg ?? Center();
    List<Widget> layout = [];
    double rows = data.length / columnCount.ceil();
    double max = data.length.toDouble() - 1;
    for (int i = 0; i < rows; i++) {
      List<Widget> items = [];
      for (double j = 0; j < columnCount; j++) {
        if (i * columnCount + j <= max) {
          items.add(buildItemLayout(i * columnCount + j.toInt()));
          if (j < columnCount - 1) {
            items.add(getMainAxisSpacing());
          }
        } else {
          items.add(new Expanded(flex: 1, child: Center()));
          if (j < columnCount - 1) {
            items.add(getMainAxisSpacing());
          }
        }
      }
      layout.add(Row(
        children: items,
      ));
      if (i < rows - 1) {
        layout.add(getCrossAxisSpacing());
      }
    }

    return Padding(
      padding: EdgeInsets.only(
          top: padding ?? paddingTop ?? 0,
          left: padding ?? paddingLeft ?? 0,
          right: padding ?? paddingRight ?? 0,
          bottom: padding ?? paddingBottom ?? 0),
      child: Container(
        child: Column(
          children: layout,
        ),
      ),
    );
  }

  Widget getMainAxisSpacing() {
    return Container(
      width: mainAxisSpacing ?? 0,
      child: Center(),
    );
  }

  Widget getCrossAxisSpacing() {
    return Container(
      height: crossAxisSpacing ?? 0,
      child: Center(),
    );
  }
}
