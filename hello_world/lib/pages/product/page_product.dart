import 'package:flutter/material.dart';
import 'package:hello_world/pages/product/busi/busi_product_body.dart';

import 'busi/busi_product_footer.dart';
import 'busi/busi_product_header.dart';

class ProductPage extends StatefulWidget {
  final int id;

  ProductPage(this.id, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductPageState();
  }
}

class ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 48),
          child: ProductBody(widget.id),
        ),
//        ProductHeader(),
//        ProductFooter(),
      ],
    );
  }
}
