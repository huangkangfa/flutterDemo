package com.flutter.demo.hello_world.helpers;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

/**
 * MethodChannel：用于传递方法调用
 * 应用场景：Flutter端 调用 Native端
 * 通过异步方法调用的方式与平台进行通信
 * /// A named channel for communicating with platform plugins using asynchronous
 * /// method calls.
 */
public class MethodChannelHelper {

    public static final String NATIVE_CHANNEL_METHOD = "test.flutter.io/native_method_channel";

    private MethodChannel mMethodChannel;

    private volatile static MethodChannelHelper mMethodChannelManager;

    private MethodChannelHelper() {
    }

    public static MethodChannelHelper getInstance() {
        if (mMethodChannelManager == null) {
            synchronized (MethodChannelHelper.class) {
                if (mMethodChannelManager == null) {
                    mMethodChannelManager = new MethodChannelHelper();
                }
            }
        }
        return mMethodChannelManager;
    }

    public void init(FlutterEngine mFlutterEngine) {
        if (mFlutterEngine != null)
            mMethodChannel = new MethodChannel(mFlutterEngine.getDartExecutor(), NATIVE_CHANNEL_METHOD);
    }

    public void setMethodCallHandler(MethodChannel.MethodCallHandler handler) {
        if (mMethodChannel != null)
            mMethodChannel.setMethodCallHandler(handler);
    }

    public void invokeMethod(String name,MethodChannel.Result result){
        if (mMethodChannel != null)
            mMethodChannel.invokeMethod(name,null,result);
    }

    public void recycle() {
        mMethodChannel = null;
    }
}
