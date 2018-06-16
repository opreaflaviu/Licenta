package com.example.licenta;

import android.net.Uri;
import android.os.Bundle;

import android.content.Intent;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "native.components";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        switch (methodCall.method) {
                            case "openMailApp":
                                openMailApp(methodCall.arguments);
                                break;
                            case "openMapsApp":
                                openMapsApp(methodCall.arguments);
                                break;

                            case "openBrowserApp":
                                openBrowserApp(methodCall.arguments);
                                break;
                        }
                    }
                }
        );
    }


    private void openMailApp(Object arguments) {
        String email = (String) arguments;
        System.out.println("Native method call   " + email);
        Intent sendIntent = new Intent(Intent.ACTION_SEND);
        sendIntent.putExtra(Intent.EXTRA_EMAIL, new String[]{email});
        sendIntent.setType("message/rfc822");
        startActivity(Intent.createChooser(sendIntent, "Choose an email app"));
    }

    private void openMapsApp(Object arguments) {
        String address = (String) arguments;
        Intent sendIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("geo:0,0?q= " + address + " Cluj"));
        sendIntent.setPackage("com.google.android.apps.maps");
        startActivity(sendIntent);
    }

    private void openBrowserApp(Object arguments) {
        String webURL = (String) arguments;
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(webURL ));
        startActivity(Intent.createChooser(browserIntent, "Chose Browser"));
    }

}
