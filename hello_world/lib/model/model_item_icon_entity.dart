import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelItemIconEntity with JsonConvert<ModelItemIconEntity> {
	int id;
	int platform;
	String name;
	String img;
	int sort;
	String url;
	int type;
	int status;
	int createdAt;
	int updatedAt;
}
