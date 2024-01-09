import 'package:get/get.dart';
import 'package:notif/controllers/mycourse_controller.dart';
import 'package:notif/services/mycourse_api_service.dart';

class MyCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCourseApiService>(
      () => MyCourseApiService(),
    );
    Get.lazyPut<MyCourseController>(
      () => MyCourseController(Get.find<MyCourseApiService>()),
    );
  }
}
