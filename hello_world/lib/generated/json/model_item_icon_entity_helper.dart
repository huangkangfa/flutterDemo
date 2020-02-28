import 'package:hello_world/model/model_item_icon_entity.dart';

modelItemIconEntityFromJson(ModelItemIconEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['platform'] != null) {
		data.platform = json['platform']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort']?.toInt();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt']?.toInt();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt']?.toInt();
	}
	return data;
}

Map<String, dynamic> modelItemIconEntityToJson(ModelItemIconEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['platform'] = entity.platform;
	data['name'] = entity.name;
	data['img'] = entity.img;
	data['sort'] = entity.sort;
	data['url'] = entity.url;
	data['type'] = entity.type;
	data['status'] = entity.status;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	return data;
}