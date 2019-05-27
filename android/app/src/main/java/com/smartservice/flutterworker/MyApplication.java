package com.smartservice.flutterworker;

import android.app.Application;
import android.content.Context;

import com.baidu.idl.face.platform.LivenessTypeEnum;

import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {
    public static Application context;
    public static Context c = null;
    public static List<LivenessTypeEnum> livenessList = new ArrayList<LivenessTypeEnum>();
    public static boolean isLivenessRandom = false;


    @Override
    public void onCreate() {
        super.onCreate();
        c = this;
    }
}
