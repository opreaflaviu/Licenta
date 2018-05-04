import 'package:connectivity/connectivity.dart';
import 'dart:async';

class NetworkConnectionUtils {

  Future<bool> isConnection() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }
}