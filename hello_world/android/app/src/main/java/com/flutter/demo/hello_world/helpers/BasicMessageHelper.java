package com.flutter.demo.hello_world.helpers;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.MessageCodec;

/**
 * BasicMessageChannel：用于传递数据。
 * 通过异步传递message与平台进行通信
 * /// A named channel for communicating with platform plugins using asynchronous
 * /// message passing.
 * <p>
 * MessageCodec对应4类如下
 * 1.BinaryCodec 原封不动将二进制数据消息返回
 * 2.StringCodec 用于字符串与二进制数据之间的编解码，其编码格式为UTF-8  示例用的是这个
 * 3.JSONMessageCodec 用于基础数据与二进制数据之间的编解码，其支持基础数据类型以及列表、字典。其在iOS端使用了NSJSONSerialization作为序列化的工具，而在Android端则使用了其自定义的JSONUtil与StringCodec作为序列化工具。
 * 4.StandardMessageCodec （默认如果不指定） 是BasicMessageChannel的默认编解码器，其支持基础数据类型、二进制数据、列表、字典。
 */
public class BasicMessageHelper<T> {

    public static final String NATIVE_CHANNEL_BASICMESSAGE = "test.flutter.io/native_basicmessage";

    private BasicMessageChannel<T> mBasicMessageChannel;

    private volatile static BasicMessageHelper mBasicMessageChannelManager;

    private BasicMessageHelper() {
    }

    public static BasicMessageHelper getInstance() {
        if (mBasicMessageChannelManager == null) {
            synchronized (BasicMessageHelper.class) {
                if (mBasicMessageChannelManager == null) {
                    mBasicMessageChannelManager = new BasicMessageHelper();
                }
            }
        }
        return mBasicMessageChannelManager;
    }

    public void init(FlutterEngine mFlutterEngine, MessageCodec<T> mMessageCodec) {
        if (mFlutterEngine != null && mMessageCodec != null)
            mBasicMessageChannel = new BasicMessageChannel<T>(mFlutterEngine.getDartExecutor(), NATIVE_CHANNEL_BASICMESSAGE, mMessageCodec);
    }

    public void setMessageHandler(BasicMessageChannel.MessageHandler<T> mMessageHandler) {
        if (mBasicMessageChannel != null) {
            mBasicMessageChannel.setMessageHandler(mMessageHandler);
        }
    }

    public void sendMessage(T obj) {
        if (mBasicMessageChannel != null) {
            mBasicMessageChannel.send(obj);
        }
    }

    public void sendMessage(T obj, BasicMessageChannel.Reply<T> callback) {
        if (mBasicMessageChannel != null) {
            mBasicMessageChannel.send(obj, callback);
        }
    }

    public void recycle() {
        mBasicMessageChannel = null;
    }
}
