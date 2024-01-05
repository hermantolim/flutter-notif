import 'package:get/get.dart';

import 'api_service.dart';

class CourseApiService extends ApiService {
  static String url = '/courses';

  Future<Response<dynamic>> load() async {
    return get(url, contentType: 'application/json');
  }
}
