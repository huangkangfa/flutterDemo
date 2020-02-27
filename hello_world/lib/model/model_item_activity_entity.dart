import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelItemActivityEntity with JsonConvert<ModelItemActivityEntity> {
	int id;
	String name;
	String subName;
	String img;
	int sort;
	String url;
	int type;
	int status;
	int createdAt;
	int updatedAt;
}
