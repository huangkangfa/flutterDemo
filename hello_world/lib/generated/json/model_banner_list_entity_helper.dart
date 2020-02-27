import 'package:hello_world/model/model_banner_list_entity.dart';

modelBannerListEntityFromJson(ModelBannerListEntity data, Map<String, dynamic> json) {
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new List<ModelBannerListData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new ModelBannerListData().fromJson(v));
		});
	}
	if (json['empty'] != null) {
		data.empty = json['empty'];
	}
	return data;
}

Map<String, dynamic> modelBannerListEntityToJson(ModelBannerListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total'] = entity.total;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['empty'] = entity.empty;
	return data;
}

modelBannerListDataFromJson(ModelBannerListData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['platform'] != null) {
		data.platform = json['platform']?.toInt();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort']?.toInt();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['position'] != null) {
		data.position = json['position']?.toInt();
	}
	return data;
}

Map<String, dynamic> modelBannerListDataToJson(ModelBannerListData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['platform'] = entity.platform;
	data['img'] = entity.img;
	data['url'] = entity.url;
	data['sort'] = entity.sort;
	data['type'] = entity.type;
	data['position'] = entity.position;
	return data;
}