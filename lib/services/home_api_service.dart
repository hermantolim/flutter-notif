import 'package:get/get.dart';

import 'api_service.dart';

class HomeApiService extends ApiService {
  static String homeUrl = '/';
  Future<Response<dynamic>> loadHome() async {
    return post(homeUrl, {}, contentType: 'application/vnd.api+json');
  }
}
