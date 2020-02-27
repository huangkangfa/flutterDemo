import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/redux/reducer/reducer_user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  ModelUserEntity userInfo;

  AppState({this.userInfo});
}

AppState appReducer(AppState state, action) {
  return AppState(
    userInfo: UserReducer(state.userInfo, action),
  );
}
