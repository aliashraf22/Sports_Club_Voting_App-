import 'dart:io';

import 'package:flutter/services.dart';

class Channels {
  static const _developerOptionsCheckChannel =
  MethodChannel('eVote/developerOptionsCheckChannel');

  static Future<bool> isDeveloperOptionsEnabled() async {
    if (!Platform.isAndroid) return false;

    try {
      final bool result = await _developerOptionsCheckChannel.invokeMethod(
        'isDeveloperOptionsEnabled',
      );
      return result;
    } on PlatformException catch (e) {
      throw 'PlatformException: ${e.message}';
    }
  }
}