import 'package:get/get.dart';
import 'package:notif/controllers/inbox_detail_controller.dart';
import 'package:notif/services/inbox_detail_api_service.dart';

class InboxDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InboxDetailApiService>(
      () => InboxDetailApiService(),
    );
    Get.lazyPut<InboxDetailController>(
      () => InboxDetailController(Get.find<InboxDetailApiService>()),
    );
  }
}
