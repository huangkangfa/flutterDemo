package com.flutter.demo.hello_world;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.fragment.app.FragmentActivity;

public class NextActivity extends FragmentActivity {

    public static void start(Context context) {
        Intent intent = new Intent(context, NextActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_next);

//        FragmentTransaction mFragmentTransaction = getSupportFragmentManager().beginTransaction();
//        mFragmentTransaction.replace(R.id.content,Flutter.createFragment("route"));
//        mFragmentTransaction.commit();

    }

}
