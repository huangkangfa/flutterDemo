import 'package:hello_world/model/model_item_find_shop_entity.dart';

modelItemFindShopEntityFromJson(ModelItemFindShopEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['shop'] != null) {
		data.shop = json['shop']?.toString();
	}
	if (json['logo'] != null) {
		data.logo = json['logo']?.toString();
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['praiseCount'] != null) {
		data.praiseCount = json['praiseCount']?.toInt();
	}
	if (json['distance'] != null) {
		data.distance = json['distance']?.toDouble();
	}
	if (json['lngLat'] != null) {
		data.lngLat = json['lngLat']?.toString();
	}
	if (json['unit'] != null) {
		data.unit = json['unit']?.toString();
	}
	return data;
}

Map<String, dynamic> modelItemFindShopEntityToJson(ModelItemFindShopEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['shop'] = entity.shop;
	data['logo'] = entity.logo;
	data['address'] = entity.address;
	data['praiseCount'] = entity.praiseCount;
	data['distance'] = entity.distance;
	data['lngLat'] = entity.lngLat;
	data['unit'] = entity.unit;
	return data;
}