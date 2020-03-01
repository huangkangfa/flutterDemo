import 'package:hello_world/model/model_find_index_entity.dart';

modelFindIndexEntityFromJson(ModelFindIndexEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['parentId'] != null) {
		data.parentId = json['parentId']?.toInt();
	}
	if (json['sort'] != null) {
		data.sort = json['sort']?.toInt();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt']?.toInt();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt']?.toInt();
	}
	return data;
}

Map<String, dynamic> modelFindIndexEntityToJson(ModelFindIndexEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['img'] = entity.img;
	data['parentId'] = entity.parentId;
	data['sort'] = entity.sort;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	return data;
}