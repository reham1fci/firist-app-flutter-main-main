import 'package:flutter/services.dart';

class MockLocationChecker {
  static const platform = MethodChannel('com.marsa.attendance/location');

  static Future<bool> isMockLocation() async {
    try {
      final bool result = await platform.invokeMethod('isMockLocation');
      return result;
    } on PlatformException catch (e) {
      print("Failed to check mock location: '${e.message}'.");
      return false;
    }
  }
}
