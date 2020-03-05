import 'package:hello_world/model/model_theme.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/redux/reducer/reducer_theme.dart';
import 'package:hello_world/redux/reducer/reducer_user.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: must_be_immutable
class AppState {
  ThemeInfo themeInfo;
  ModelUserEntity userInfo;

  AppState({this.userInfo,this.themeInfo});
}

AppState appReducer(AppState state, action) {
  return AppState(
    userInfo: UserReducer(state.userInfo, action),
    themeInfo: ThemeReducer(state.themeInfo,action),
  );
}
