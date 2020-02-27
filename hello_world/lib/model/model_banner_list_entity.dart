import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelBannerListEntity with JsonConvert<ModelBannerListEntity> {
	int total;
	List<ModelBannerListData> data;
	bool empty;
}

class ModelBannerListData with JsonConvert<ModelBannerListData> {
	int id;
	int platform;
	String img;
	String url;
	int sort;
	int type;
	int position;
}
