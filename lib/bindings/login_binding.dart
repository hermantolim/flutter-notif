import 'package:get/get.dart';
import 'package:notif/controllers/login_controller.dart';
import 'package:notif/services/auth_service.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(
          Get.find<AuthApiService>(),
        ));
  }
}
