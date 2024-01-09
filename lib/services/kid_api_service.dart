import 'package:get/get.dart';

import 'api_service.dart';

class KidApiService extends ApiService {
  static String url = '/kids';

  Future<Response<dynamic>> load() async {
    return get(url, contentType: 'application/json');
  }
}
