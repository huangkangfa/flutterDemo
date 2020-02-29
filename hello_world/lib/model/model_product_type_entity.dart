import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelProductTypeEntity with JsonConvert<ModelProductTypeEntity> {
	dynamic img;
	List<ModelProductTypechild> children;
	int groupId;
	String name;
	int id;
}

class ModelProductTypechild with JsonConvert<ModelProductTypechild> {
	String img;
	List<ModelProductTypechildchild> children;
	int groupId;
	String name;
	int id;
}

class ModelProductTypechildchild with JsonConvert<ModelProductTypechildchild> {
	String img;
	int groupId;
	String name;
	int id;
}
