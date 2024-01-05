import 'dart:developer';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:get/get.dart';
import 'package:notif/services/inbox_detail_api_service.dart';

class InboxDetailController extends GetxController with StateMixin {
  final InboxDetailApiService _inboxDetailApiService;

  InboxDetailController(this._inboxDetailApiService);

  Rx<Message?> message = Rx(null);
  //Rx<List<Message>> messageList = Rx<List<Message>>(RxList([]));

  //List<Message> get messages => messageList.value;
  //final isLoading = false.obs;

  @override
  onInit() async {
    change(null, status: RxStatus.loading());
    String id = Get.parameters['id'] ?? '';
    print('argument $id');
    await getMessage(id);
    //await load();
    log('inbox loaded successfully');
    super.onInit();
  }

  Future updateStatus(String id) async {
    try {
      var response = await _inboxDetailApiService.updateState(id);
      if (response.statusCode == 401) {}
      if (response.statusCode == 200) {
        change({"body": state.body, "state": MessageState.read},
            status: RxStatus.success());
      } else {
        change(state, status: RxStatus.empty());
      }
    } catch (err, _) {
      log('$err');
      rethrow;
    }
  }

  Future getMessage(String id) async {
    try {
      var response = await _inboxDetailApiService.load(id);
      if (response.statusCode == 401) {
        // Get.toNamed(Routes.LOGIN);
      }
      if (response.statusCode == 200) {
        //return json.decode(response.body);
        final body = Message.fromJson(response.body);
        change({"body": body, "state": body.state}, status: RxStatus.success());
        //message.value = body;
      } else {
        //message.value = null;
        change(null, status: RxStatus.empty());
      }
      // var message = response.toString();
      //

      // log('${json.decode(response.body)}');
    } catch (err, _) {
      log('$err');
      rethrow;
    }
  }
}
