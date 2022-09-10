import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nike_flutter/core/network/network_info.dart';

/// check network connectivity implementation
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected => _checkInternetConnection();

  Future<bool> _checkInternetConnection() async {
    bool state = true;
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      state = false;
    } else {
      state = true;
    }
    debugPrint('Internet State: ${result.name}');
    return state;
  }
}
