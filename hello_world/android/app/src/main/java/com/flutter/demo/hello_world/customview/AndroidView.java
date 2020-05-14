package com.flutter.demo.hello_world.customview;

import android.content.Context;
import android.view.View;

import com.flutter.demo.hello_world.helpers.BasicMessageHelper;
import com.flutter.demo.hello_world.R;

import io.flutter.plugin.platform.PlatformView;

public class AndroidView implements PlatformView {
    private View rootView;

    public AndroidView(Context context) {
        rootView = View.inflate(context,R.layout.item_android_view,null);
        rootView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                BasicMessageHelper.getInstance().sendMessage("哈哈哈哈哈哈");
            }
        });
    }

    @Override
    public View getView() {
        return rootView;
    }

    @Override
    public void onFlutterViewAttached(View flutterView) {

    }

    @Override
    public void onFlutterViewDetached() {

    }

    @Override
    public void dispose() {

    }

    @Override
    public void onInputConnectionLocked() {

    }

    @Override
    public void onInputConnectionUnlocked() {

    }
}
