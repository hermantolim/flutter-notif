import 'package:get/get.dart';
import 'package:notif/controllers/home_controller.dart';
import 'package:notif/services/home_api_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeApiService>(() => HomeApiService());
    Get.lazyPut<HomeController>(
        () => HomeController(Get.find<HomeApiService>()));
  }
}
