import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WatchListMainController extends GetxController {
  GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
