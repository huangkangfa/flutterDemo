// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:hello_world/model/model_refresh_list_entity.dart';
import 'package:hello_world/generated/json/model_refresh_list_entity_helper.dart';
import 'package:hello_world/model/model_product_type_entity.dart';
import 'package:hello_world/generated/json/model_product_type_entity_helper.dart';
import 'package:hello_world/model/model_com_icon_entity.dart';
import 'package:hello_world/generated/json/model_com_icon_entity_helper.dart';
import 'package:hello_world/model/model_item_product_entity.dart';
import 'package:hello_world/generated/json/model_item_product_entity_helper.dart';
import 'package:hello_world/model/model_banner_list_entity.dart';
import 'package:hello_world/generated/json/model_banner_list_entity_helper.dart';
import 'package:hello_world/model/model_item_activity_entity.dart';
import 'package:hello_world/generated/json/model_item_activity_entity_helper.dart';
import 'package:hello_world/model/model_find_index_entity.dart';
import 'package:hello_world/generated/json/model_find_index_entity_helper.dart';
import 'package:hello_world/model/model_item_shop_entity.dart';
import 'package:hello_world/generated/json/model_item_shop_entity_helper.dart';
import 'package:hello_world/model/model_user_entity.dart';
import 'package:hello_world/generated/json/model_user_entity_helper.dart';
import 'package:hello_world/model/model_item_find_shop_entity.dart';
import 'package:hello_world/generated/json/model_item_find_shop_entity_helper.dart';
import 'package:hello_world/model/model_item_icon_entity.dart';
import 'package:hello_world/generated/json/model_item_icon_entity_helper.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/generated/json/model_product_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case ModelRefreshListEntity:
			return modelRefreshListEntityFromJson(data as ModelRefreshListEntity, json) as T;			case ModelProductTypeEntity:
			return modelProductTypeEntityFromJson(data as ModelProductTypeEntity, json) as T;			case ModelProductTypechild:
			return modelProductTypechildFromJson(data as ModelProductTypechild, json) as T;			case ModelProductTypechildchild:
			return modelProductTypechildchildFromJson(data as ModelProductTypechildchild, json) as T;			case ModelComIconEntity:
			return modelComIconEntityFromJson(data as ModelComIconEntity, json) as T;			case ModelItemProductEntity:
			return modelItemProductEntityFromJson(data as ModelItemProductEntity, json) as T;			case ModelBannerListEntity:
			return modelBannerListEntityFromJson(data as ModelBannerListEntity, json) as T;			case ModelBannerListData:
			return modelBannerListDataFromJson(data as ModelBannerListData, json) as T;			case ModelItemActivityEntity:
			return modelItemActivityEntityFromJson(data as ModelItemActivityEntity, json) as T;			case ModelFindIndexEntity:
			return modelFindIndexEntityFromJson(data as ModelFindIndexEntity, json) as T;			case ModelItemShopEntity:
			return modelItemShopEntityFromJson(data as ModelItemShopEntity, json) as T;			case ModelUserEntity:
			return modelUserEntityFromJson(data as ModelUserEntity, json) as T;			case ModelItemFindShopEntity:
			return modelItemFindShopEntityFromJson(data as ModelItemFindShopEntity, json) as T;			case ModelItemIconEntity:
			return modelItemIconEntityFromJson(data as ModelItemIconEntity, json) as T; case ModelProductEntity:
			return modelProductEntityFromJson(data as ModelProductEntity, json) as T;			case ModelProductProductCommantCountReponseList:
			return modelProductProductCommantCountReponseListFromJson(data as ModelProductProductCommantCountReponseList, json) as T;			case ModelProductProductComment:
			return modelProductProductCommentFromJson(data as ModelProductProductComment, json) as T;			case ModelProductProductAttrList:
			return modelProductProductAttrListFromJson(data as ModelProductProductAttrList, json) as T;			case ModelProductProductSkuList:
			return modelProductProductSkuListFromJson(data as ModelProductProductSkuList, json) as T;			case ModelProductUserAddressResponses:
			return modelProductUserAddressResponsesFromJson(data as ModelProductUserAddressResponses, json) as T;   }
    return data as T;
  }  static _getToJson<T>(Type type, data) {
		switch (type) {			case ModelRefreshListEntity:
			return modelRefreshListEntityToJson(data as ModelRefreshListEntity);			case ModelProductTypeEntity:
			return modelProductTypeEntityToJson(data as ModelProductTypeEntity);			case ModelProductTypechild:
			return modelProductTypechildToJson(data as ModelProductTypechild);			case ModelProductTypechildchild:
			return modelProductTypechildchildToJson(data as ModelProductTypechildchild);			case ModelComIconEntity:
			return modelComIconEntityToJson(data as ModelComIconEntity);			case ModelItemProductEntity:
			return modelItemProductEntityToJson(data as ModelItemProductEntity);			case ModelBannerListEntity:
			return modelBannerListEntityToJson(data as ModelBannerListEntity);			case ModelBannerListData:
			return modelBannerListDataToJson(data as ModelBannerListData);			case ModelItemActivityEntity:
			return modelItemActivityEntityToJson(data as ModelItemActivityEntity);			case ModelFindIndexEntity:
			return modelFindIndexEntityToJson(data as ModelFindIndexEntity);			case ModelItemShopEntity:
			return modelItemShopEntityToJson(data as ModelItemShopEntity);			case ModelUserEntity:
			return modelUserEntityToJson(data as ModelUserEntity);			case ModelItemFindShopEntity:
			return modelItemFindShopEntityToJson(data as ModelItemFindShopEntity);			case ModelItemIconEntity:
			return modelItemIconEntityToJson(data as ModelItemIconEntity); case ModelProductEntity:
			return modelProductEntityToJson(data as ModelProductEntity);			case ModelProductProductCommantCountReponseList:
			return modelProductProductCommantCountReponseListToJson(data as ModelProductProductCommantCountReponseList);			case ModelProductProductComment:
			return modelProductProductCommentToJson(data as ModelProductProductComment);			case ModelProductProductAttrList:
			return modelProductProductAttrListToJson(data as ModelProductProductAttrList);			case ModelProductProductSkuList:
			return modelProductProductSkuListToJson(data as ModelProductProductSkuList);			case ModelProductUserAddressResponses:
			return modelProductUserAddressResponsesToJson(data as ModelProductUserAddressResponses);     }
    return data as T;
  }  static T fromJsonAsT<T>(json) {
    switch (T.toString()) {			case 'ModelRefreshListEntity':
			return ModelRefreshListEntity().fromJson(json) as T;			case 'ModelProductTypeEntity':
			return ModelProductTypeEntity().fromJson(json) as T;			case 'ModelProductTypechild':
			return ModelProductTypechild().fromJson(json) as T;			case 'ModelProductTypechildchild':
			return ModelProductTypechildchild().fromJson(json) as T;			case 'ModelComIconEntity':
			return ModelComIconEntity().fromJson(json) as T;			case 'ModelItemProductEntity':
			return ModelItemProductEntity().fromJson(json) as T;			case 'ModelBannerListEntity':
			return ModelBannerListEntity().fromJson(json) as T;			case 'ModelBannerListData':
			return ModelBannerListData().fromJson(json) as T;			case 'ModelItemActivityEntity':
			return ModelItemActivityEntity().fromJson(json) as T;			case 'ModelFindIndexEntity':
			return ModelFindIndexEntity().fromJson(json) as T;			case 'ModelItemShopEntity':
			return ModelItemShopEntity().fromJson(json) as T;			case 'ModelUserEntity':
			return ModelUserEntity().fromJson(json) as T;			case 'ModelItemFindShopEntity':
			return ModelItemFindShopEntity().fromJson(json) as T;			case 'ModelItemIconEntity':
			return ModelItemIconEntity().fromJson(json) as T; case 'ModelProductEntity':
			return ModelProductEntity().fromJson(json) as T;			case 'ModelProductProductCommantCountReponseList':
			return ModelProductProductCommantCountReponseList().fromJson(json) as T;			case 'ModelProductProductComment':
			return ModelProductProductComment().fromJson(json) as T;			case 'ModelProductProductAttrList':
			return ModelProductProductAttrList().fromJson(json) as T;			case 'ModelProductProductSkuList':
			return ModelProductProductSkuList().fromJson(json) as T;			case 'ModelProductUserAddressResponses':
			return ModelProductUserAddressResponses().fromJson(json) as T;    }
    return null;
  }}