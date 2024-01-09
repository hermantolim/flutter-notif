import 'package:get/get.dart';
import 'package:notif/controllers/kid_controller.dart';
import 'package:notif/services/kid_api_service.dart';

class KidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KidApiService>(
      () => KidApiService(),
    );
    Get.lazyPut<KidController>(
      () => KidController(Get.find<KidApiService>()),
    );
  }
}
