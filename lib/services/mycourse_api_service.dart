import 'package:get/get.dart';

import 'api_service.dart';

class MyCourseApiService extends ApiService {
  static String url = '/courses/my';

  Future<Response<dynamic>> load() async {
    return get(url, contentType: 'application/json');
  }
}
