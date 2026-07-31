import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';

class DeviceService extends GetxService {
  final RxString _deviceId = ''.obs;
  final RxString _appVersion = ''.obs;
  final RxString _buildNumber = ''.obs;
  final RxString _os = ''.obs;
  final RxString _packageName = ''.obs;
  static DeviceService? _instance;

  static DeviceService get instance {
    _instance ??= DeviceService();
    return _instance!;
  }

  Future<DeviceService> init() async {
    await _initializeDeviceDetails();
    return this;
  }

  Future<void> _initializeDeviceDetails() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final id = await FlutterUdid.udid;
      _deviceId.value = id;
      _appVersion.value = packageInfo.version;
      _buildNumber.value = packageInfo.buildNumber;
      _packageName.value = packageInfo.packageName;
      _os.value = Platform.isAndroid
          ? 'Android'
          : Platform.isIOS
              ? 'iOS'
              : 'Unknown';
    } catch (e) {
      _deviceId.value = 'Unknown';
      _appVersion.value = 'Unknown';
      _buildNumber.value = 'Unknown';
      _os.value = 'Unknown';
      _packageName.value = 'Unknown';
      debugPrint("Error initializing device details: $e");
    }
  }

  String get deviceId => _deviceId.value;
  String get appVersion => _appVersion.value;
  String get buildNumber => _buildNumber.value;
  String get os => _os.value;
  String get packageName => _packageName.value;
}
