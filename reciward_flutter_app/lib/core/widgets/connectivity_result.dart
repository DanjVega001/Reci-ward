import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class MyConnectivity extends ChangeNotifier{

  static Future<ConnectivityResult> getConnectivity() async {
    return await Connectivity().checkConnectivity();
  }
}