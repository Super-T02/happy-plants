import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';

class Util {
  /// Starts the loading Animation
  static void startLoading() {
    navigatorKey.currentState!.push(
      MaterialPageRoute(
          builder: (context) => const SpinKitFadingCircle(color: Colors.white)),
    );
  }

  /// Ends loading
  static void endLoading() {
    navigatorKey.currentState!.pop();
  }

  static String? getStringFromDateTime(DateTime? input) {
    if (input != null) {
      return "${input.day.toString()}.${input.month.toString()}.${input.year.toString()}";
    } else {
      return null;
    }
  }
}
