import 'package:hello_world/model/model_item_shop_entity.dart';

modelItemShopEntityFromJson(ModelItemShopEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['shop'] != null) {
		data.shop = json['shop']?.toString();
	}
	if (json['advertisingImg'] != null) {
		data.advertisingImg = json['advertisingImg']?.toString();
	}
	if (json['distance'] != null) {
		data.distance = json['distance']?.toString();
	}
	return data;
}

Map<String, dynamic> modelItemShopEntityToJson(ModelItemShopEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['shop'] = entity.shop;
	data['advertisingImg'] = entity.advertisingImg;
	data['distance'] = entity.distance;
	return data;
}