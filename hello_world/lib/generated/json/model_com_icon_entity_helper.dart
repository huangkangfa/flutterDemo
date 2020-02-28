import 'package:hello_world/model/model_com_icon_entity.dart';

modelComIconEntityFromJson(ModelComIconEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	return data;
}

Map<String, dynamic> modelComIconEntityToJson(ModelComIconEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['img'] = entity.img;
	return data;
}