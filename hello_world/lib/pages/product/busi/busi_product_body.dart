import 'package:flutter/material.dart';
import 'package:hello_world/dao/dao_product.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/pages/product/busi/busi_product_body_select.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';

import 'busi_product_body_comment.dart';
import 'busi_product_body_html.dart';
import 'busi_product_body_shop.dart';
import 'busi_product_body_swiper.dart';
import 'busi_product_body_title.dart';
import 'busi_product_header.dart';

class ProductBody extends StatefulWidget {
  final int id;

  ProductBody(this.id, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductBodyState();
  }
}

class ProductBodyState extends State<ProductBody> {
  ModelProductEntity data;
  ScrollController controller;
  bool isShowAppbar = false;
  int indexOfHeader = 0; //0:商品 1：评价  2：详情

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset > ScreenUtil().setWidth(300) && !isShowAppbar) {
        isShowAppbar = true;
        sendEvent(ProductHeaderEvent("isShowHeader", flag: true));
      } else if (controller.offset <= ScreenUtil().setWidth(300) &&
          isShowAppbar) {
        isShowAppbar = false;
        sendEvent(ProductHeaderEvent("isShowHeader", flag: false));
      }
    });
    refreshData();
  }

  refreshData() {
    ProductDao.getProductDetail({'id': widget.id}).then((result) {
      setState(() {
        data = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.all(0),
      children: <Widget>[
        ProductDetailSwiper(data?.imageList ?? [], videoUrl: data?.videoUrl),
        ProductDetailTitle(data),
        ProductSelect(),
        ProductComment(data),
        ProductDetailShop(data),
        ProductDetailHtml(data?.detail ?? '')
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}
