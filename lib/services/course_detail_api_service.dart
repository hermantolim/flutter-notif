import 'package:get/get.dart';

import 'api_service.dart';

class CourseDetailApiService extends ApiService {
  static String url = '/courses';
  static String enrollUrl = '/enrollment';

  Future<Response<dynamic>> load(String id) async {
    return get("$url/$id", contentType: 'application/json');
  }

  Future<Response<dynamic>> enroll(String id) async {
    return post(
      enrollUrl,
      {
        "course_id": id,
      },
      contentType: 'application/json',
    );
  }
}
