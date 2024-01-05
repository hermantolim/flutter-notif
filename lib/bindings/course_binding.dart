import 'package:get/get.dart';
import 'package:notif/controllers/course_controller.dart';
import 'package:notif/services/course_api_service.dart';

class CourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseApiService>(
      () => CourseApiService(),
    );
    Get.lazyPut<CourseController>(
      () => CourseController(Get.find<CourseApiService>()),
    );
  }
}
