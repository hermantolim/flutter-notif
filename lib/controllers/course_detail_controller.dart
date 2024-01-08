import 'dart:developer';

import 'package:edclass_api_client/edclass_api_client.dart';
import 'package:get/get.dart';
import 'package:notif/services/course_detail_api_service.dart';

class CourseDetailController extends GetxController with StateMixin {
  final CourseDetailApiService _courseDetailApiService;

  CourseDetailController(this._courseDetailApiService);

  @override
  onInit() async {
    change(null, status: RxStatus.loading());
    String id = Get.parameters['id'] ?? '';
    print('argument $id');
    await getItem(id);
    //await load();
    log('inbox loaded successfully');
    super.onInit();
  }

  Future enroll(String id) async {
    try {
      change(state, status: RxStatus.loading());
      var response = await _courseDetailApiService.enroll(id);
      if (response.statusCode == 401) {}
      if (response.statusCode == 200) {
        GetCourseResponse? courseResponse = state;
        print("GetCourseResponse $courseResponse");
        if (courseResponse != null) {
          change(
            GetCourseResponse(
              course: courseResponse.course,
              teacher: courseResponse.teacher,
              students: courseResponse.students,
              enrolled: true,
            ),
            status: RxStatus.success(),
          );
        }
      } else {
        change(state, status: RxStatus.empty());
      }
    } catch (err, _) {
      log('$err');
      rethrow;
    }
  }

  Future getItem(String id) async {
    try {
      var response = await _courseDetailApiService.load(id);
      if (response.statusCode == 401) {
        // Get.toNamed(Routes.LOGIN);
      }
      if (response.statusCode == 200) {
        //return json.decode(response.body);
        final body = GetCourseResponse.fromJson(response.body);
        change(body, status: RxStatus.success());
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
