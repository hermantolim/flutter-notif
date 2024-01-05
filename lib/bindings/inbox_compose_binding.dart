import 'package:get/get.dart';
import 'package:notif/controllers/inbox_compose_controller.dart';
import 'package:notif/services/inbox_compose_api_service.dart';

class InboxComposeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InboxComposeApiService>(() => InboxComposeApiService());
    Get.lazyPut<InboxComposeController>(
        () => InboxComposeController(Get.find<InboxComposeApiService>()));
  }
}
