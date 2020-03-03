import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/dao/dao_product.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_placeholder.dart';
import 'package:hello_world/widget/base_toast.dart';

class ProductBody extends StatefulWidget {
  final int id;

  ProductBody(this.id, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductBodyState();
  }
}

class ProductBodyState extends State<ProductBody> {
  int curBannerIndex = 0;
  ModelProductEntity data;

  @override
  void initState() {
    super.initState();
//    _controller = VideoPlayerController.path("http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")..initialize();
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
    if (data == null) {
      return PlaceHolderView(ScreenUtil().setWidth(ScreenUtil.screenWidthDp),
          ScreenUtil().setWidth(250),
          padding: 0, radius: 0);
    }
    int count = data.imageList.length;
    if (data.videoUrl != null) {
      count++;
    }

    return Container(
      color: Colors.yellow,
      height: ScreenUtil().setWidth(250),
      child: Swiper(
        autoplay: false,
        index: curBannerIndex,
        onIndexChanged: (index) {
          curBannerIndex = index;
        },
        onTap: (index) {
          showToast('index = ' + index.toString());
        },
        itemBuilder: (BuildContext context, int index) =>
            buildItemLayout(context, index),
        itemCount: count,
        viewportFraction: 1,
        pagination: SwiperPagination(),
        scale: 1,
      ),
    );
  }

  buildItemLayout(BuildContext context, int index) {
    if (data.videoUrl == null) {
      if (index == 0) {
//        return ;
      } else {
        return CachedNetworkImage(
          imageUrl: data.imageList[index - 1],
          fit: BoxFit.fill,
        );
      }
    }
    return CachedNetworkImage(
      imageUrl: data.imageList[index],
      fit: BoxFit.fill,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
