import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  static void logInfo(String message) {
    if (kDebugMode) {
      log(message);
    }
  }
}