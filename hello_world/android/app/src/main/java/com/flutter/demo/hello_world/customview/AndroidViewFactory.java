package com.flutter.demo.hello_world.customview;

import android.content.Context;

import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class AndroidViewFactory extends PlatformViewFactory {

    public static final String TAG = "com.flutter.demo/android_view";
    public static final String KEY = "AndroidView";

    private BinaryMessenger messenger;

    public AndroidViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    public AndroidViewFactory(BinaryMessenger messenger,MessageCodec<Object> messageCodec) {
        super(messageCodec);
        this.messenger = messenger;
    }


    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        return new AndroidView(context);
    }

    public static void registerWith(FlutterEngine flutterEngine) {
        ShimPluginRegistry registry = new ShimPluginRegistry(flutterEngine);
        if (registry.hasPlugin(KEY)) return;
        PluginRegistry.Registrar registrar = registry.registrarFor(KEY);
        registrar.platformViewRegistry().registerViewFactory(TAG, new AndroidViewFactory(registrar.messenger()));
    }
}
