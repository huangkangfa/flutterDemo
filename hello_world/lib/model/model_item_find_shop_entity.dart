import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelItemFindShopEntity with JsonConvert<ModelItemFindShopEntity> {
	int id;
	String shop;
	String logo;
	String address;
	int praiseCount;
	double distance;
	String lngLat;
	String unit;
}
