import 'package:get/get.dart';
import 'package:notif/controllers/register_controller.dart';
import 'package:notif/services/auth_service.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(
          Get.find<AuthApiService>(),
        ));
  }
}
