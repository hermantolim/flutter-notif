import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notif/services/home_api_service.dart';

class HomeController extends GetxController with StateMixin {
  final HomeApiService _homeApiService;
  final box = GetStorage();
  HomeController(this._homeApiService);

  @override
  onInit() async {
    change(null, status: RxStatus.loading());
    //var response = await load();
    log('Home loaded successfully');
    // if done, change status to success
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future load() async {
    try {
      // var message = response.toString();
      //

      // log('${json.decode(response.body)}');
    } catch (err, _) {
      log('$err');
      rethrow;
    }
  }
}
