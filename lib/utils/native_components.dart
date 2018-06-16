import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:licenta/exception/my_exception.dart';

class NativeComponents {
  static const _platform = const MethodChannel('native.components');

  static Future<Null> openMailApp(String email) async {
    try {
      await _platform.invokeMethod("openMailApp", email);
    } on PlatformException catch (e) {
      throw new MyException("Message $e");
    }
  }

  static Future<Null> openMapsApp(String address) async {
    try {
      await _platform.invokeMethod("openMapsApp", address);
    } on PlatformException catch(e){
      throw new MyException("Message $e");
    }
  }

  static Future<Null> openBrowserApp(String web) async {

    try {
      await _platform.invokeMethod("openBrowserApp", web);
    } on PlatformException catch(e){
      throw new MyException("Message $e");
    }
  }


}