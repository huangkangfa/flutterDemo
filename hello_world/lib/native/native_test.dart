import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';

class NativeTest {
  static const MethodChannel methodChannel =
      MethodChannel('test.flutter.io/native_method_channel');
  static const EventChannel eventChannel =
      const EventChannel('test.flutter.io/native_event_channel');
  static const basicMessageChannel = const BasicMessageChannel(
      'test.flutter.io/native_basicmessage', StringCodec());

  /// MethodChannel方式 主动调用原生方法并接收参数
  static Future<String> testMethodChannel() async {
    try {
      String result = await methodChannel.invokeMethod('showNativeToast');
      LogUtil.v("成功 >>>> " + result, tag: "testMethodChannel");
      return result;
    } on PlatformException catch (e) {
      LogUtil.e("失败 >>>> " + e.details.toString(), tag: "testMethodChannel");
    }
    return null;
  }

  static goToNativePage(){
    methodChannel.invokeMapMethod("goToNextActivity");
  }

  /// MethodChannel方式 被动接收原生发送的数据
  static registerMethodCallHandler() {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "getFlutterName":
          return "这是flutter返回的数据";
      }
      return "";
    });
  }

  /// EventChannel方式 被动接收原生发送的数据,而且不能回复
  static registerEventBroadcast(Function success, Function error) {
    eventChannel.receiveBroadcastStream().listen(success, onError: error);
  }

  /// BasicMessageChannel方式 接收与发送
  static testBasicMessageChannel() {
    //接受并回复消息
    basicMessageChannel.setMessageHandler(
      (String message) => Future<String>(() {
        return "回复native消息";
      }),
    );
    //发送消息
    basicMessageChannel.send("来自flutter的message");
    //flutter并没有发送并接受回复消息的`send(T message, BasicMessageChannel.Reply<T> callback)`方法
  }

}
