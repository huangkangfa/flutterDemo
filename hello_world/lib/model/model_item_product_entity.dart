import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelItemProductEntity with JsonConvert<ModelItemProductEntity> {
	int id;
	String name;
	String images;
	int price;
	String videoUrl;
	int isVipPrice;
	int minVipPrice;
	int type;
}
