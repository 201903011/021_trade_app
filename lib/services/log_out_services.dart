// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:minimals/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:minimals/routes/app_pages.dart';
import 'package:minimals/services/global_service.dart';

@Singleton()
class LogOutServices {
  final GlobalService globalService;

  LogOutServices({
    required this.globalService,
  });

  final storage = GetStorage();

  Future<void> logOut(BuildContext context, void Function() onCancel) async {
    Get.deleteAll();
    await storage.remove(StorageKeys.authToken);
    await storage.remove(StorageKeys.userModel);
    await storage.remove(StorageKeys.userSession);
    await storage.remove(StorageKeys.isLogin);
    await storage.remove(StorageKeys.txnFlow);
    await storage.remove(StorageKeys.txnStatus);
    await storage.remove(StorageKeys.pin);

    await storage.save();

    Get.offAllNamed(Routes.login);
  }
}
