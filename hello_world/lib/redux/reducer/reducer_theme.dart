import 'package:hello_world/model/model_theme.dart';
import 'package:redux/redux.dart';

///通过 flutter_redux 的 combineReducers，创建 Reducer<State>
final ThemeReducer = combineReducers<ThemeInfo>([
  ///将Action，处理Action动作的方法，State绑定
  TypedReducer<ThemeInfo, RefreshThemeAction>(_refreshTheme),
]);

///定义处理 Action 行为的方法，返回新的 State
ThemeInfo _refreshTheme(ThemeInfo index, action) {
  index = action.data;
  return index;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshThemeAction {
  final ThemeInfo data;

  RefreshThemeAction(this.data);
}
