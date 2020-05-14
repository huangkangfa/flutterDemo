package com.flutter.demo.hello_world.helpers;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;

/**
 * EventChannel:用于传递事件。
 * 应用场景：Native端 调用 Flutter端
 * 通过流的方式与平台进行通信
 * /// A named channel for communicating with platform plugins using event streams.
 */
public class EventChannelHelper {
    public static final String NATIVE_CHANNEL_EVENT = "test.flutter.io/native_event_channel";

    private EventChannel mEventChannel;

    private EventChannel.EventSink mEventSink;

    private volatile static EventChannelHelper mEventChannelManager;

    private EventChannelHelper() {
    }

    public static EventChannelHelper getInstance() {
        if (mEventChannelManager == null) {
            synchronized (EventChannelHelper.class) {
                if (mEventChannelManager == null) {
                    mEventChannelManager = new EventChannelHelper();
                }
            }
        }
        return mEventChannelManager;
    }

    public void init(FlutterEngine mFlutterEngine) {
        if (mFlutterEngine != null)
            mEventChannel = new EventChannel(mFlutterEngine.getDartExecutor(), NATIVE_CHANNEL_EVENT);
    }

    public void setStreamHandler(EventChannel.StreamHandler mStreamHandler) {
        if (mEventChannel != null)
            mEventChannel.setStreamHandler(new EventChannel.StreamHandler() {
                @Override
                public void onListen(Object arguments, EventChannel.EventSink events) {
                    mEventSink = events;
                    mStreamHandler.onListen(arguments, events);
                }

                @Override
                public void onCancel(Object arguments) {
                    mEventSink = null;
                    mStreamHandler.onCancel(arguments);
                }
            });
    }

    public void sendMessage(String msg) {
        if (mEventSink != null) {
            mEventSink.success(msg);
        }
    }

    public void recycle() {
        mEventSink = null;
        mEventChannel = null;
    }

}
