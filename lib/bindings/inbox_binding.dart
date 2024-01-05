import 'package:get/get.dart';
import 'package:notif/controllers/inbox_controller.dart';
import 'package:notif/controllers/inbox_sent_controller.dart';
import 'package:notif/services/inbox_api_service.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InboxApiService>(
      () => InboxApiService(),
    );
    Get.lazyPut<InboxSentController>(
      () => InboxSentController(Get.find<InboxApiService>()),
    );
    Get.lazyPut<InboxController>(
      () => InboxController(Get.find<InboxApiService>()),
    );
  }
}
