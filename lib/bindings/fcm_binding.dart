import 'package:get/get.dart';
import 'package:notif/controllers/fcm_controller.dart';
import 'package:notif/services/fcm_api_service.dart';

class FcmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FcmApiService>(
      () => FcmApiService(),
    );
    Get.lazyPut<FcmController>(
      () => FcmController(Get.find<FcmApiService>()),
    );
  }
}
