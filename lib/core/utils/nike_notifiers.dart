import 'package:flutter/foundation.dart';
import 'package:nike_flutter/core/network/network_info.dart';

import '../di/dependencies.dart';

class NikeNotifiers {
  /// notify when user login or logout
  static final ValueNotifier<bool> authRefreshNotifier = ValueNotifier(false);

  ///notify when user add product to cart
  static final ValueNotifier<bool> cartRefreshNotifier = ValueNotifier(false);

  static final ValueNotifier<bool> tryConnection = ValueNotifier(false);

  static void checkConnection() {
    debugPrint("release Mode: checkConnection");
    di<NetworkInfo>().isConnected.asStream().listen((event) {
      debugPrint("release Mode: checkConnection: $event");
      if (event) {
        tryConnection.value = event;
      }
    });
  }
}
