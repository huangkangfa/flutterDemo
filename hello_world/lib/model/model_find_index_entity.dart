import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelFindIndexEntity with JsonConvert<ModelFindIndexEntity> {
	int id;
	String name;
	String img;
	int parentId;
	int sort;
	int createdAt;
	int updatedAt;
}
