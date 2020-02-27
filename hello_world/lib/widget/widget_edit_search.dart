import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';

///编辑搜索控件widget
class EditSearchWidget extends StatelessWidget {
  final Function onChanged, onSubmitted;

  EditSearchWidget({Key key,this.onChanged, this.onSubmitted}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: editView(),
          flex: 1,
        )
      ],
    );
  }

  Widget editView() {
    final controller = TextEditingController();
    FocusNode _thisFocus = FocusNode();
    return Container(
      //修饰黑色背景与圆角
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.colorFontHint, width: 1.0),
        //灰色的一层边框
        color: ThemeColors.colorBg_EEECEC,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      height: 30,
      padding: EdgeInsets.only(
          left: ThemeSize.marginSizeMin, right: ThemeSize.marginSizeMin),
      child: TextField(
        controller: controller,
        focusNode: _thisFocus,
        //设置光标
        cursorColor: ThemeColors.colorFont_999,
        //最大行数
        maxLines: 1,
        //是否是密码
        obscureText: false,
        onChanged: (text) {
          if (onChanged != null) onChanged(text);
        },
        onSubmitted: (text) {
          if (onSubmitted != null) onSubmitted(text);
          _thisFocus.unfocus();
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 9, bottom: 9, left: -15),
            icon: Icon(Icons.search, color: ThemeColors.colorFont_333),
            hintText: "请输入搜索内容",
            hintStyle: TextStyle(
                fontSize: 14,
                textBaseline: TextBaseline.alphabetic,
                color: ThemeColors.colorFontHint)),
        style: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            fontSize: 14,
            color: ThemeColors.colorFont_333),
      ),
    );
  }
}
