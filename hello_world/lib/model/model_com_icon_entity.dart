import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelComIconEntity with JsonConvert<ModelComIconEntity> {
	String name;
	String img;
	ModelComIconEntity({this.name,this.img});
}
