import 'package:hello_world/model/model_product_entity.dart';

modelProductEntityFromJson(ModelProductEntity data, Map<String, dynamic> json) {
	if (json['productName'] != null) {
		data.productName = json['productName']?.toString();
	}
	if (json['imageList'] != null) {
		data.imageList = json['imageList']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['videoUrl'] != null) {
		data.videoUrl = json['videoUrl']?.toString();
	}
	if (json['minPrice'] != null) {
		data.minPrice = json['minPrice']?.toInt();
	}
	if (json['cityName'] != null) {
		data.cityName = json['cityName']?.toString();
	}
	if (json['soldAmount'] != null) {
		data.soldAmount = json['soldAmount']?.toInt();
	}
	if (json['detail'] != null) {
		data.detail = json['detail']?.toString();
	}
	if (json['phoneNumber'] != null) {
		data.phoneNumber = json['phoneNumber']?.toString();
	}
	if (json['mchId'] != null) {
		data.mchId = json['mchId']?.toInt();
	}
	if (json['logo'] != null) {
		data.logo = json['logo']?.toString();
	}
	if (json['shopName'] != null) {
		data.shopName = json['shopName']?.toString();
	}
	if (json['advertisingImg'] != null) {
		data.advertisingImg = json['advertisingImg']?.toString();
	}
	if (json['businessHours'] != null) {
		data.businessHours = json['businessHours'];
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['freightPrice'] != null) {
		data.freightPrice = json['freightPrice']?.toInt();
	}
	if (json['freightId'] != null) {
		data.freightId = json['freightId']?.toInt();
	}
	if (json['freightName'] != null) {
		data.freightName = json['freightName']?.toString();
	}
	if (json['productType'] != null) {
		data.productType = json['productType']?.toInt();
	}
	if (json['isVipPrice'] != null) {
		data.isVipPrice = json['isVipPrice']?.toInt();
	}
	if (json['minVipPrice'] != null) {
		data.minVipPrice = json['minVipPrice']?.toInt();
	}
	if (json['newbieStatus'] != null) {
		data.newbieStatus = json['newbieStatus']?.toInt();
	}
	if (json['maxNewbiePrice'] != null) {
		data.maxNewbiePrice = json['maxNewbiePrice']?.toInt();
	}
	if (json['minNewbiePrice'] != null) {
		data.minNewbiePrice = json['minNewbiePrice']?.toInt();
	}
	if (json['minMarkingPrice'] != null) {
		data.minMarkingPrice = json['minMarkingPrice']?.toInt();
	}
	if (json['originalPrice'] != null) {
		data.originalPrice = json['originalPrice']?.toInt();
	}
	if (json['productCommentCountReponseList'] != null) {
		data.productCommentCountReponseList = new List<ModelProductProductCommantCountReponseList>();
		(json['productCommentCountReponseList'] as List).forEach((v) {
			data.productCommentCountReponseList.add(new ModelProductProductCommantCountReponseList().fromJson(v));
		});
	}
	if (json['productComment'] != null) {
		data.productComment = new ModelProductProductComment().fromJson(json['productComment']);
	}
	if (json['productAttrList'] != null) {
		data.productAttrList = new List<ModelProductProductAttrList>();
		(json['productAttrList'] as List).forEach((v) {
			data.productAttrList.add(new ModelProductProductAttrList().fromJson(v));
		});
	}
	if (json['productSkuList'] != null) {
		data.productSkuList = new List<ModelProductProductSkuList>();
		(json['productSkuList'] as List).forEach((v) {
			data.productSkuList.add(new ModelProductProductSkuList().fromJson(v));
		});
	}
	if (json['couponList'] != null) {
		data.couponList = new List<dynamic>();
		data.couponList.addAll(json['couponList']);
	}
	if (json['userAddressResponses'] != null) {
		data.userAddressResponses = new ModelProductUserAddressResponses().fromJson(json['userAddressResponses']);
	}
	return data;
}

Map<String, dynamic> modelProductEntityToJson(ModelProductEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['productName'] = entity.productName;
	data['imageList'] = entity.imageList;
	data['videoUrl'] = entity.videoUrl;
	data['minPrice'] = entity.minPrice;
	data['cityName'] = entity.cityName;
	data['soldAmount'] = entity.soldAmount;
	data['detail'] = entity.detail;
	data['phoneNumber'] = entity.phoneNumber;
	data['mchId'] = entity.mchId;
	data['logo'] = entity.logo;
	data['shopName'] = entity.shopName;
	data['advertisingImg'] = entity.advertisingImg;
	data['businessHours'] = entity.businessHours;
	data['address'] = entity.address;
	data['freightPrice'] = entity.freightPrice;
	data['freightId'] = entity.freightId;
	data['freightName'] = entity.freightName;
	data['productType'] = entity.productType;
	data['isVipPrice'] = entity.isVipPrice;
	data['minVipPrice'] = entity.minVipPrice;
	data['newbieStatus'] = entity.newbieStatus;
	data['maxNewbiePrice'] = entity.maxNewbiePrice;
	data['minNewbiePrice'] = entity.minNewbiePrice;
	data['minMarkingPrice'] = entity.minMarkingPrice;
	data['originalPrice'] = entity.originalPrice;
	if (entity.productCommentCountReponseList != null) {
		data['productCommentCountReponseList'] =  entity.productCommentCountReponseList.map((v) => v.toJson()).toList();
	}
	if (entity.productComment != null) {
		data['productComment'] = entity.productComment.toJson();
	}
	if (entity.productAttrList != null) {
		data['productAttrList'] =  entity.productAttrList.map((v) => v.toJson()).toList();
	}
	if (entity.productSkuList != null) {
		data['productSkuList'] =  entity.productSkuList.map((v) => v.toJson()).toList();
	}
	if (entity.couponList != null) {
		data['couponList'] =  [];
	}
	if (entity.userAddressResponses != null) {
		data['userAddressResponses'] = entity.userAddressResponses.toJson();
	}
	return data;
}

modelProductProductCommantCountReponseListFromJson(ModelProductProductCommantCountReponseList data, Map<String, dynamic> json) {
	if (json['commentCount'] != null) {
		data.commentCount = json['commentCount']?.toInt();
	}
	if (json['star'] != null) {
		data.star = json['star']?.toInt();
	}
	return data;
}

Map<String, dynamic> modelProductProductCommantCountReponseListToJson(ModelProductProductCommantCountReponseList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['commentCount'] = entity.commentCount;
	data['star'] = entity.star;
	return data;
}

modelProductProductCommentFromJson(ModelProductProductComment data, Map<String, dynamic> json) {
	if (json['userName'] != null) {
		data.userName = json['userName']?.toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar']?.toString();
	}
	if (json['detail'] != null) {
		data.detail = json['detail']?.toString();
	}
	if (json['imageList'] != null) {
		data.imageList = json['imageList']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	return data;
}

Map<String, dynamic> modelProductProductCommentToJson(ModelProductProductComment entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['userName'] = entity.userName;
	data['avatar'] = entity.avatar;
	data['detail'] = entity.detail;
	data['imageList'] = entity.imageList;
	return data;
}

modelProductProductAttrListFromJson(ModelProductProductAttrList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['uid'] != null) {
		data.uid = json['uid']?.toInt();
	}
	if (json['productId'] != null) {
		data.productId = json['productId']?.toInt();
	}
	if (json['mchId'] != null) {
		data.mchId = json['mchId']?.toInt();
	}
	if (json['attrId'] != null) {
		data.attrId = json['attrId']?.toInt();
	}
	if (json['attrName'] != null) {
		data.attrName = json['attrName']?.toString();
	}
	if (json['attrValues'] != null) {
		data.attrValues = json['attrValues']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt']?.toInt();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt']?.toInt();
	}
	if (json['attrValueList'] != null) {
		data.attrValueList = json['attrValueList']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	return data;
}

Map<String, dynamic> modelProductProductAttrListToJson(ModelProductProductAttrList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['uid'] = entity.uid;
	data['productId'] = entity.productId;
	data['mchId'] = entity.mchId;
	data['attrId'] = entity.attrId;
	data['attrName'] = entity.attrName;
	data['attrValues'] = entity.attrValues;
	data['status'] = entity.status;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['attrValueList'] = entity.attrValueList;
	return data;
}

modelProductProductSkuListFromJson(ModelProductProductSkuList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['productCode'] != null) {
		data.productCode = json['productCode']?.toString();
	}
	if (json['productSkuCode'] != null) {
		data.productSkuCode = json['productSkuCode']?.toString();
	}
	if (json['mchId'] != null) {
		data.mchId = json['mchId']?.toInt();
	}
	if (json['uid'] != null) {
		data.uid = json['uid']?.toInt();
	}
	if (json['productId'] != null) {
		data.productId = json['productId']?.toInt();
	}
	if (json['attrValue'] != null) {
		data.attrValue = json['attrValue']?.toString();
	}
	if (json['attrAmount'] != null) {
		data.attrAmount = json['attrAmount']?.toInt();
	}
	if (json['amount'] != null) {
		data.amount = json['amount']?.toInt();
	}
	if (json['totalAmount'] != null) {
		data.totalAmount = json['totalAmount']?.toInt();
	}
	if (json['freezeAmount'] != null) {
		data.freezeAmount = json['freezeAmount']?.toInt();
	}
	if (json['activityAmount'] != null) {
		data.activityAmount = json['activityAmount']?.toInt();
	}
	if (json['soldAmount'] != null) {
		data.soldAmount = json['soldAmount']?.toInt();
	}
	if (json['initialAmount'] != null) {
		data.initialAmount = json['initialAmount']?.toInt();
	}
	if (json['cost'] != null) {
		data.cost = json['cost']?.toInt();
	}
	if (json['originalPrice'] != null) {
		data.originalPrice = json['originalPrice']?.toInt();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toInt();
	}
	if (json['activityPrice'] != null) {
		data.activityPrice = json['activityPrice']?.toInt();
	}
	if (json['vipPrice'] != null) {
		data.vipPrice = json['vipPrice']?.toInt();
	}
	if (json['newbieStatus'] != null) {
		data.newbieStatus = json['newbieStatus']?.toInt();
	}
	if (json['isOnePrice'] != null) {
		data.isOnePrice = json['isOnePrice']?.toInt();
	}
	if (json['newbiePrice'] != null) {
		data.newbiePrice = json['newbiePrice']?.toInt();
	}
	if (json['integral'] != null) {
		data.integral = json['integral']?.toString();
	}
	if (json['markingPrice'] != null) {
		data.markingPrice = json['markingPrice']?.toInt();
	}
	if (json['number'] != null) {
		data.number = json['number']?.toInt();
	}
	if (json['imageUrl'] != null) {
		data.imageUrl = json['imageUrl']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['refundType'] != null) {
		data.refundType = json['refundType']?.toString();
	}
	if (json['validity'] != null) {
		data.validity = json['validity']?.toString();
	}
	if (json['buyLimit'] != null) {
		data.buyLimit = json['buyLimit']?.toInt();
	}
	if (json['barCodeUrl'] != null) {
		data.barCodeUrl = json['barCodeUrl']?.toString();
	}
	if (json['mchProductCode'] != null) {
		data.mchProductCode = json['mchProductCode']?.toString();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt']?.toInt();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt']?.toInt();
	}
	if (json['attrValueMap'] != null) {
		data.attrValueMap = json['attrValueMap']?.toString();
	}
	return data;
}

Map<String, dynamic> modelProductProductSkuListToJson(ModelProductProductSkuList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['productCode'] = entity.productCode;
	data['productSkuCode'] = entity.productSkuCode;
	data['mchId'] = entity.mchId;
	data['uid'] = entity.uid;
	data['productId'] = entity.productId;
	data['attrValue'] = entity.attrValue;
	data['attrAmount'] = entity.attrAmount;
	data['amount'] = entity.amount;
	data['totalAmount'] = entity.totalAmount;
	data['freezeAmount'] = entity.freezeAmount;
	data['activityAmount'] = entity.activityAmount;
	data['soldAmount'] = entity.soldAmount;
	data['initialAmount'] = entity.initialAmount;
	data['cost'] = entity.cost;
	data['originalPrice'] = entity.originalPrice;
	data['price'] = entity.price;
	data['activityPrice'] = entity.activityPrice;
	data['vipPrice'] = entity.vipPrice;
	data['newbieStatus'] = entity.newbieStatus;
	data['isOnePrice'] = entity.isOnePrice;
	data['newbiePrice'] = entity.newbiePrice;
	data['integral'] = entity.integral;
	data['markingPrice'] = entity.markingPrice;
	data['number'] = entity.number;
	data['imageUrl'] = entity.imageUrl;
	data['status'] = entity.status;
	data['refundType'] = entity.refundType;
	data['validity'] = entity.validity;
	data['buyLimit'] = entity.buyLimit;
	data['barCodeUrl'] = entity.barCodeUrl;
	data['mchProductCode'] = entity.mchProductCode;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['attrValueMap'] = entity.attrValueMap;
	return data;
}

modelProductUserAddressResponsesFromJson(ModelProductUserAddressResponses data, Map<String, dynamic> json) {
	if (json['province'] != null) {
		data.province = json['province']?.toString();
	}
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['cityCode'] != null) {
		data.cityCode = json['cityCode']?.toString();
	}
	if (json['area'] != null) {
		data.area = json['area']?.toString();
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['isDefault'] != null) {
		data.isDefault = json['isDefault']?.toString();
	}
	return data;
}

Map<String, dynamic> modelProductUserAddressResponsesToJson(ModelProductUserAddressResponses entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['province'] = entity.province;
	data['city'] = entity.city;
	data['cityCode'] = entity.cityCode;
	data['area'] = entity.area;
	data['address'] = entity.address;
	data['isDefault'] = entity.isDefault;
	return data;
}