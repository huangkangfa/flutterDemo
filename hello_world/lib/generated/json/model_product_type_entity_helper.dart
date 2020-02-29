import 'package:hello_world/model/model_product_type_entity.dart';

modelProductTypeEntityFromJson(ModelProductTypeEntity data, Map<String, dynamic> json) {
	if (json['img'] != null) {
		data.img = json['img'];
	}
	if (json['children'] != null) {
		data.children = new List<ModelProductTypechild>();
		(json['children'] as List).forEach((v) {
			data.children.add(new ModelProductTypechild().fromJson(v));
		});
	}
	if (json['groupId'] != null) {
		data.groupId = json['groupId']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	return data;
}

Map<String, dynamic> modelProductTypeEntityToJson(ModelProductTypeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['img'] = entity.img;
	if (entity.children != null) {
		data['children'] =  entity.children.map((v) => v.toJson()).toList();
	}
	data['groupId'] = entity.groupId;
	data['name'] = entity.name;
	data['id'] = entity.id;
	return data;
}

modelProductTypechildFromJson(ModelProductTypechild data, Map<String, dynamic> json) {
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['children'] != null) {
		data.children = new List<ModelProductTypechildchild>();
		(json['children'] as List).forEach((v) {
			data.children.add(new ModelProductTypechildchild().fromJson(v));
		});
	}
	if (json['groupId'] != null) {
		data.groupId = json['groupId']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	return data;
}

Map<String, dynamic> modelProductTypechildToJson(ModelProductTypechild entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['img'] = entity.img;
	if (entity.children != null) {
		data['children'] =  entity.children.map((v) => v.toJson()).toList();
	}
	data['groupId'] = entity.groupId;
	data['name'] = entity.name;
	data['id'] = entity.id;
	return data;
}

modelProductTypechildchildFromJson(ModelProductTypechildchild data, Map<String, dynamic> json) {
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['groupId'] != null) {
		data.groupId = json['groupId']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	return data;
}

Map<String, dynamic> modelProductTypechildchildToJson(ModelProductTypechildchild entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['img'] = entity.img;
	data['groupId'] = entity.groupId;
	data['name'] = entity.name;
	data['id'] = entity.id;
	return data;
}