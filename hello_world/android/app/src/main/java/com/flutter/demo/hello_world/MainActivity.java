package com.flutter.demo.hello_world;

import android.widget.Toast;

import androidx.annotation.NonNull;

import com.flutter.demo.hello_world.customview.AndroidViewFactory;
import com.flutter.demo.hello_world.helpers.BasicMessageHelper;
import com.flutter.demo.hello_world.helpers.EventChannelHelper;
import com.flutter.demo.hello_world.helpers.MethodChannelHelper;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        initTest(flutterEngine);//原生flutter通讯
        AndroidViewFactory.registerWith(flutterEngine);//原生view嵌入flutter
    }

    private void initTest(FlutterEngine flutterEngine) {

        //MethodChannel通讯
        MethodChannelHelper.getInstance().init(flutterEngine);
        //EventChannel通讯
        EventChannelHelper.getInstance().init(flutterEngine);
        //BasicMessageChannel通讯
        BasicMessageHelper.getInstance().init(flutterEngine, StringCodec.INSTANCE);


        /**
         * 第一种 MethodChannel方式 接收flutter那边发来的数据，并返回
         */
        MethodChannelHelper.getInstance().setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                switch (call.method) {
                    case "showNativeToast":
                        Toast.makeText(MainActivity.this, "展示原生的toast", Toast.LENGTH_SHORT).show();
                        result.success("这是原生返回的数据");
//                        result.error("-1", "原生返回的错误", new Object());
                        break;
                    case "goToNextActivity":
                        NextActivity.start(MainActivity.this);
                        break;
                    default:
                        result.notImplemented();
                }
            }
        });

        /**
         * 第二种 EventChannel方式 接收flutter那边发来的数据
         */
        EventChannelHelper.getInstance().setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                Toast.makeText(MainActivity.this, "接收flutter数据 >>>> " + arguments.toString(), Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onCancel(Object arguments) {
            }
        });

        /**
         * 第三种 BasicMessageChannel方式 接收flutter那边发来的数据
         */
        BasicMessageHelper.getInstance().setMessageHandler(new BasicMessageChannel.MessageHandler() {
            @Override
            public void onMessage(Object message, BasicMessageChannel.Reply reply) {
                Toast.makeText(MainActivity.this, "接收flutter数据 >>>> " + message.toString(), Toast.LENGTH_SHORT).show();
                reply.reply("回馈消息");
            }
        });
    }

    public void sendMsgToFlutter() {
        /**
         * 第一种 MethodChannel方式发送给flutter
         */
        MethodChannelHelper.getInstance().invokeMethod("getFlutterName", new MethodChannel.Result() {
            @Override
            public void success(Object result) {
                Toast.makeText(MainActivity.this, "原生拿到flutter结果 >>> " + result.toString(), Toast.LENGTH_SHORT).show();
            }

            @Override
            public void error(String errorCode, String errorMessage, Object errorDetails) {

            }

            @Override
            public void notImplemented() {

            }
        });

        /**
         * 第二种 EventChannel方式发送给flutter
         */
        EventChannelHelper.getInstance().sendMessage("原生发给flutter数据");

        /**
         * 第三种 BasicMessageChannel方式发送给flutter
         */
        BasicMessageHelper.getInstance().sendMessage("原生发给flutter数据", new BasicMessageChannel.Reply<String>() {
            @Override
            public void reply(String reply) {
                if (reply != null)
                    Toast.makeText(MainActivity.this, "接收flutter的反馈 >>> " + reply, Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        MethodChannelHelper.getInstance().recycle();
        EventChannelHelper.getInstance().recycle();
        BasicMessageHelper.getInstance().recycle();
    }
}
