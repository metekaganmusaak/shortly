import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  // we define a boolean variable which holds itself a false value defaultly
  var hasConnection = false.obs;

  // creating instance
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    // when the app launches, we need to check internet connection
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      return _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        hasConnection.value = true;
        break;

      case ConnectivityResult.wifi:
        hasConnection.value = true;
        break;

      case ConnectivityResult.none:
        hasConnection.value = false;
        break;

      default:
        Get.snackbar("Network Error", "Failed to get network connection");
        break;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();

  }
}
