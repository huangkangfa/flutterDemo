import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/configs/app_size.dart';

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
        border: Border.all(color: AppColors.C_BC, width: 1.0),
        //灰色的一层边框
        color: AppColors.C_EC,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      height: 30,
      padding: EdgeInsets.only(
          left: AppSize.marginSizeMin, right: AppSize.marginSizeMin),
      child: TextField(
        controller: controller,
        focusNode: _thisFocus,
        //设置光标
        cursorColor: AppColors.C_999,
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
            icon: Icon(Icons.search, color: AppColors.C_333),
            hintText: "请输入搜索内容",
            hintStyle: TextStyle(
                fontSize: 14,
                textBaseline: TextBaseline.alphabetic,
                color: AppColors.C_BC)),
        style: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            fontSize: 14,
            color: AppColors.C_333),
      ),
    );
  }


}
