import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_placeholder.dart';
import 'package:hello_world/widget/base_toast.dart';
import 'package:hello_world/widget/video/widget_video_view.dart';

class ProductDetailSwiper extends StatefulWidget {
  final String videoUrl;
  final List<String> imgUrlList;

  ProductDetailSwiper(this.imgUrlList, {this.videoUrl, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailSwiperState();
  }
}

class ProductDetailSwiperState extends State<ProductDetailSwiper> {
  int curBannerIndex = 0;
  int startTime = 0;
  bool isPause = false;

  @override
  Widget build(BuildContext context) {
    if (widget.imgUrlList == null || widget.imgUrlList.length == 0) {
      return PlaceHolderView(ScreenUtil().setWidth(ScreenUtil.screenWidthDp),
          ScreenUtil().setWidth(250),
          padding: 0, radius: 0);
    }
    int count = widget.imgUrlList.length;
    if (widget.videoUrl != null) {
      count++;
    }

    return Container(
        height: ScreenUtil().setWidth(300),
        child: Swiper(
          autoplay: false,
          loop: false,
          index: curBannerIndex,
          onIndexChanged: (index) {
            curBannerIndex = index;
          },
          itemBuilder: (BuildContext context, int index) =>
              buildItemLayout(context, index),
          itemCount: count,
          viewportFraction: 1,
          pagination: buildCustomPagination(),
          scale: 1,
        ));
  }

  buildItemLayout(BuildContext context, int index) {
    if (widget.videoUrl != null) {
      if (index == 0) {
        return VideoView(
          url: widget.videoUrl,
          startTime: startTime,
          isPause: isPause,
          currentPrograss: (time) {
            startTime = time;
          },
          playStatus: (result) {
            isPause = result;
          },
        );
      } else {
        return CachedNetworkImage(
          imageUrl: widget.imgUrlList[index - 1],
          fit: BoxFit.fill,
        );
      }
    }
    return CachedNetworkImage(
      imageUrl: widget.imgUrlList[index],
      fit: BoxFit.fill,
    );
  }

  buildCustomPagination() {
    return SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
      bool hide = widget.videoUrl != null && curBannerIndex == 0;
      return Visibility(
        visible: !hide,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(ThemeSize.marginSizeMid),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ThemeSize.marginSizeMax),
              child: Container(
                color: Color(0x30000000),
                constraints:
                    BoxConstraints(maxWidth: ScreenUtil().setWidth(100)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${config.activeIndex + 1}',
                      style: TextStyle(
                          fontSize: ThemeSize.fontSize14,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(color: Colors.black26, offset: Offset(0, 1)),
                          ]),
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                          fontSize: ThemeSize.fontSize14,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(color: Colors.black26, offset: Offset(0, 1)),
                          ]),
                    ),
                    Text('${config.itemCount}',
                        style: TextStyle(
                            fontSize: ThemeSize.fontSizeMid,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                  color: Colors.black26, offset: Offset(0, 1)),
                            ])),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
