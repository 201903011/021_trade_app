// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:minimals/config/config_data.dart';
import 'package:minimals/config/models/app_config.dart';
import 'package:minimals/models/user_model.dart';
import 'package:minimals/services/firebase_services/remote_config_service.dart';

class Config extends GetxService {
  late String baseUrl;
  late String s3Url;
  late bool isLive;

  final AppConfig defaultConfigData;
  late UserModel user;

  static Config? _instance;

  Config({
    required this.defaultConfigData,
  }) {
    baseUrl = defaultConfigData.baseUrl;
    s3Url = defaultConfigData.s3Url;
    isLive = defaultConfigData.isLive;
  }

  static Config get instance {
    _instance ??= Config(defaultConfigData: devDefaultConfig);
    return _instance!;
  }

  Future<Config> init() async {
    await _loadConfigWithRetry();
    return this;
  }

  Future<void> _loadConfigWithRetry({int maxRetries = 2, Duration retryDelay = const Duration(seconds: 2)}) async {
    int retryCount = 0;
    while (retryCount < maxRetries) {
      try {
        await _loadConfigFromRemote();
        return;
      } catch (e) {
        if (retryCount == (maxRetries - 1)) {
          baseUrl = defaultConfigData.baseUrl;
          s3Url = defaultConfigData.s3Url;
          isLive = defaultConfigData.isLive;
          return;
        } else {
          retryCount++;
          if (retryCount >= maxRetries) {
            // debugPrint(
            //     "Error loading config from remote after $retryCount attempts: $e");
            throw Exception('Failed to load config from remote after $retryCount retries');
          }
          // debugPrint(
          //     "Retrying to load config from remote... Attempt $retryCount");
          await Future.delayed(retryDelay); // Wait before retrying
        }
      }
    }
  }

  Future<void> _loadConfigFromRemote() async {
    try {
      final remoteConfigService = Get.find<RemoteConfigService>();
      String appConfigJson = remoteConfigService.getString('config');
      if (appConfigJson.isEmpty) {
        throw Exception("Remote config 'appConfig' is empty.");
      }
      final configData = json.decode(appConfigJson) as Map<String, dynamic>;

      baseUrl = configData['baseUrl'] ?? defaultConfigData.baseUrl;
      s3Url = configData['s3Url'] ?? defaultConfigData.s3Url;
      isLive = configData['isLive'] ?? defaultConfigData.isLive;
    } catch (e) {
      // debugPrint("Error loading config from remote: $e");
      rethrow;
    }
  }

// Function to request storage permission
  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      debugPrint("check permission true");
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        debugPrint("check permission if granted");
        return true;
      } else {
        if (await Permission.photos.request().isDenied) {
          debugPrint("check permission open");
          await openAppSettings();
        }
      }
    }
    return false;
  }
}
