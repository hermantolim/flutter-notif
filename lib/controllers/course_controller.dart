import 'dart:developer';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:get/get.dart';
import 'package:notif/services/course_api_service.dart';

class CourseController extends GetxController with StateMixin {
  final CourseApiService _courseApiService;

  CourseController(this._courseApiService);

  //Rx<List<Message>> messageList = Rx<List<Message>>(RxList([]));

  //List<Message> get messages => messageList.value;
  //final isLoading = false.obs;

  @override
  onInit() async {
    change(null, status: RxStatus.loading());
    await load();
    log('inbox loaded successfully');
    super.onInit();
  }

  Future load() async {
    try {
      var response = await _courseApiService.load();
      if (response.statusCode == 401) {
        // Get.toNamed(Routes.LOGIN);
      }
      if (response.statusCode == 200) {
        //return json.decode(response.body);
        final bodyList = response.body as List? ?? [];
        final courseList = bodyList.map((e) {
          return CourseEnrollment.fromJson(e);
        }).toList();
        change(courseList, status: RxStatus.success());
      } else {
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
