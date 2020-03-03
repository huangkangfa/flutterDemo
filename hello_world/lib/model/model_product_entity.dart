import 'package:hello_world/generated/json/base/json_convert_content.dart';

class ModelProductEntity with JsonConvert<ModelProductEntity> {
	String productName;
	List<String> imageList;
	String videoUrl;
	int minPrice;
	String cityName;
	int soldAmount;
	String detail;
	String phoneNumber;
	int mchId;
	String logo;
	String shopName;
	String advertisingImg;
	dynamic businessHours;
	String address;
	int freightPrice;
	int freightId;
	String freightName;
	int productType;
	int isVipPrice;
	int minVipPrice;
	int newbieStatus;
	int maxNewbiePrice;
	int minNewbiePrice;
	int minMarkingPrice;
	int originalPrice;
	List<ModelProductProductCommantCountReponseList> productCommentCountReponseList;
	ModelProductProductComment productComment;
	List<ModelProductProductAttrList> productAttrList;
	List<ModelProductProductSkuList> productSkuList;
	List<dynamic> couponList;
	ModelProductUserAddressResponses userAddressResponses;
}

class ModelProductProductCommantCountReponseList with JsonConvert<ModelProductProductCommantCountReponseList> {
	int commentCount;
	int star;
}

class ModelProductProductComment with JsonConvert<ModelProductProductComment> {
	String userName;
	String avatar;
	String detail;
	List<String> imageList;
}

class ModelProductProductAttrList with JsonConvert<ModelProductProductAttrList> {
	int id;
	int uid;
	int productId;
	int mchId;
	int attrId;
	String attrName;
	String attrValues;
	int status;
	int createdAt;
	int updatedAt;
	List<String> attrValueList;
}

class ModelProductProductSkuList with JsonConvert<ModelProductProductSkuList> {
	int id;
	String productCode;
	String productSkuCode;
	int mchId;
	int uid;
	int productId;
	String attrValue;
	int attrAmount;
	int amount;
	int totalAmount;
	int freezeAmount;
	int activityAmount;
	int soldAmount;
	int initialAmount;
	int cost;
	int originalPrice;
	int price;
	int activityPrice;
	int vipPrice;
	int newbieStatus;
	int isOnePrice;
	int newbiePrice;
	String integral;
	int markingPrice;
	int number;
	String imageUrl;
	int status;
	String refundType;
	String validity;
	int buyLimit;
	String barCodeUrl;
	String mchProductCode;
	int createdAt;
	int updatedAt;
	String attrValueMap;
}

class ModelProductUserAddressResponses with JsonConvert<ModelProductUserAddressResponses> {
	String province;
	String city;
	String cityCode;
	String area;
	String address;
	String isDefault;
}
