import 'package:get/get.dart';
import 'package:notif/controllers/auth_controller.dart';
import 'package:notif/controllers/fcm_controller.dart';
import 'package:notif/services/auth_service.dart';
import 'package:notif/services/connection_service.dart';
import 'package:notif/services/fcm_api_service.dart';
import 'package:notif/services/notification_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService() {
    Get.put(
      AuthController(Get.put(AuthApiService())),
      permanent: true,
    );
    Get.put(FcmApiService(), permanent: true);
    Get.put(FcmController(Get.find<FcmApiService>()), permanent: true);
    Get.put(FCMService(), permanent: true);
    Get.put(ConnectionService());
  }
}
