import 'package:hello_world/model/model_item_product_entity.dart';

modelItemProductEntityFromJson(
    ModelItemProductEntity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['images'] != null) {
    data.images = json['images']?.toString();
  }
  if (json['price'] != null) {
    data.price = json['price']?.toInt();
  }
  if (json['videoUrl'] != null) {
    data.videoUrl = json['videoUrl']?.toString();
  }
  if (json['isVipPrice'] != null) {
    data.isVipPrice = json['isVipPrice']?.toInt();
  }
  if (json['minVipPrice'] != null) {
    data.minVipPrice = json['minVipPrice']?.toInt();
  }
  if (json['type'] != null) {
    data.type = json['type']?.toInt();
  }
  return data;
}

Map<String, dynamic> modelItemProductEntityToJson(
    ModelItemProductEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['images'] = entity.images;
  data['price'] = entity.price;
  data['videoUrl'] = entity.videoUrl;
  data['isVipPrice'] = entity.isVipPrice;
  data['minVipPrice'] = entity.minVipPrice;
  data['type'] = entity.type;
  return data;
}
