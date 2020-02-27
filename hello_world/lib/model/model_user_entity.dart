import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelUserEntity with JsonConvert<ModelUserEntity> {
	String name;
	String headImg;
	ModelUserEntity({this.name,this.headImg});
}
