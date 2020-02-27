import 'package:hello_world/model/model_user_entity.dart';
import 'package:redux/redux.dart';

///通过 flutter_redux 的 combineReducers，创建 Reducer<State>
final UserReducer = combineReducers<ModelUserEntity>([
  ///将Action，处理Action动作的方法，State绑定
  TypedReducer<ModelUserEntity, RefreshUserDataAction>(_refreshUserInfo),
]);

///定义处理 Action 行为的方法，返回新的 State
ModelUserEntity _refreshUserInfo(ModelUserEntity userInfo, action) {
  userInfo = action.data;
  return userInfo;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshUserDataAction {
  final ModelUserEntity data;

  RefreshUserDataAction(this.data);
}
