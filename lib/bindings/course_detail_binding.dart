import 'package:get/get.dart';
import 'package:notif/controllers/course_detail_controller.dart';
import 'package:notif/services/course_detail_api_service.dart';

class CourseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseDetailApiService>(
      () => CourseDetailApiService(),
    );
    Get.lazyPut<CourseDetailController>(
      () => CourseDetailController(Get.find<CourseDetailApiService>()),
    );
  }
}
