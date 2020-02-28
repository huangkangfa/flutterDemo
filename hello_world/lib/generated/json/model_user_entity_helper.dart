import 'package:hello_world/model/model_user_entity.dart';

modelUserEntityFromJson(ModelUserEntity data, Map<String, dynamic> json) {
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['headImg'] != null) {
    data.headImg = json['headImg']?.toString();
  }
  return data;
}

Map<String, dynamic> modelUserEntityToJson(ModelUserEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = entity.name;
  data['headImg'] = entity.headImg;
  return data;
}
