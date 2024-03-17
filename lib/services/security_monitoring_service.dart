import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:learn/channels/channels.dart';

class SecurityMonitoringService {
  static Future<bool> initSecurityCheck() async {
    bool isRooted = await _checkIfDeviceIsRooted();
    bool isSimulated = await _checkIfDeviceIsSimulated();
    bool isDeveloper = await _checkIfDeveloperOptionsEnabled();

    return !(isRooted || isSimulated || isDeveloper);
  }

  static Future<bool> _checkIfDeviceIsRooted() async {
    /// Checks if device is rooted/jail broken or using frida
    return await JailbreakRootDetection.instance.isJailBroken;

  }

  static Future<bool> _checkIfDeviceIsSimulated() async {
    /// Checks if device is emulator/simulator
    return !await JailbreakRootDetection.instance.isRealDevice;
  }

  static Future<bool> _checkIfDeveloperOptionsEnabled() async {
    return await Channels.isDeveloperOptionsEnabled();
  }
}
