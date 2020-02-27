import 'package:hello_world/model/model_refresh_list_entity.dart';

modelRefreshListEntityFromJson(ModelRefreshListEntity data, Map<String, dynamic> json) {
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new List<dynamic>();
		data.data.addAll(json['data']);
	}
	if (json['empty'] != null) {
		data.empty = json['empty'];
	}
	return data;
}

Map<String, dynamic> modelRefreshListEntityToJson(ModelRefreshListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total'] = entity.total;
	if (entity.data != null) {
		data['data'] =  [];
	}
	data['empty'] = entity.empty;
	return data;
}