import 'package:flutter/material.dart';
import 'package:hello_world/dao/dao_product.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/pages/product/busi/busi_product_body_select.dart';

import 'busi_product_body_comment.dart';
import 'busi_product_body_html.dart';
import 'busi_product_body_shop.dart';
import 'busi_product_body_swiper.dart';
import 'busi_product_body_title.dart';

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

  @override
  void initState() {
    super.initState();
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
  }
}
